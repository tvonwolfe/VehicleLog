# frozen_string_literal: true

module Authentication
  # represents a user's JWT, used for authenticating/authorizing requests where required
  class Token
    include ActiveModel::Model

    SECRET = Rails.application.secret_key_base.freeze

    validates :iat, :exp, :iss, :uid, presence: true
    validate :issued_in_past

    attr_reader :iat, :exp, :iss, :uid, :opts

    class Invalid < StandardError; end
    class Expired < Invalid; end

    class << self
      # @param user [User]
      # @param expiration [DateTime]
      # @param opts [Hash]
      def generate(user:, expiration: 3.months.from_now, **)
        new(uid: user.id, iat: Time.current, exp: expiration, **)
      end

      def decode(encoded_token)
        payload = JWT.decode(encoded_token, SECRET).first.deep_symbolize_keys
        new(
          uid: payload.delete(:uid),
          iat: Time.at(payload.delete(:iat)).utc,
          exp: Time.at(payload.delete(:exp)).utc,
          iss: payload.delete(:iss),
          **payload
        )
      rescue JWT::ExpiredSignature => e
        raise Expired, e.message
      rescue JWT::DecodeError => e
        raise Invalid, e.message
      end
    end

    def initialize(**args)
      @uid = args.delete(:uid)
      @exp = args.delete(:exp)
      @iat = args.delete(:iat) || Time.current
      @iss = args.delete(:iss) || default_issuer
      @opts = args # whatever's left
    end

    def encode!
      encoded_token = JWT.encode(payload, SECRET)
      destroy_instance_variables!

      encoded_token
    end

    def to_cookie!
      {
        expires: exp,
        domain: iss,
        httponly: true,
        secure: Rails.env.production?,
        value: encode!
      }
    end

    def expired?
      exp.past?
    end

    private

    attr_writer :iat, :exp, :iss, :uid, :opts

    def payload
      {
        uid:,
        iat: iat.to_i,
        exp: exp.to_i,
        iss:
      }.merge(opts).with_indifferent_access
    end

    def destroy_instance_variables!
      instance_variables.each { |iv| instance_variable_set(iv, nil) }
    end

    def default_issuer
      ENV.fetch('HOST_DOMAIN')
    end

    def issued_in_past
      return if iat.past?

      errors.add(:iat, 'must have been issued in the past')
    end
  end
end
