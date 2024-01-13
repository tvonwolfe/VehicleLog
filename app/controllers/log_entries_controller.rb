# frozen_string_literal: true

class LogEntriesController < ApplicationController
  before_action :set_vehicle, only: :index
  before_action :set_log_entry, only: %i[show edit update destroy]
  authorize_resource

  def index
    @log_entries = @vehicle.log_entries
  end

  # GET /log_entries/1 or /log_entries/1.json
  def show; end

  # GET /log_entries/new
  def new
    @log_entry = LogEntry.new
  end

  # GET /log_entries/1/edit
  def edit; end

  # POST /log_entries or /log_entries.json
  def create
    @log_entry = LogEntry.new(log_entry_params)

    respond_to do |format|
      if @log_entry.save
        format.html { redirect_to log_entry_url(@log_entry), notice: 'Log entry was successfully created.' }
        format.json { render :show, status: :created, location: @log_entry }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @log_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /log_entries/1 or /log_entries/1.json
  def update
    respond_to do |format|
      if @log_entry.update(log_entry_params)
        format.html { redirect_to log_entry_url(@log_entry), notice: 'Log entry was successfully updated.' }
        format.json { render :show, status: :ok, location: @log_entry }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @log_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /log_entries/1 or /log_entries/1.json
  def destroy
    @log_entry.destroy!

    respond_to do |format|
      format.html { redirect_to log_entries_url, notice: 'Log entry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_log_entry
    @log_entry = LogEntry.find(params[:id])
  end

  def set_vehicle
    @vehicle = Vehicle.find(params[:vehicle_id])
  end

  # Only allow a list of trusted parameters through.
  def log_entry_params
    params.fetch(:log_entry, {})
  end
end
