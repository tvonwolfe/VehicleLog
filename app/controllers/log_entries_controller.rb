# frozen_string_literal: true

class LogEntriesController < ApplicationController
  before_action :set_vehicle, only: %i[index create new]
  before_action :set_log_entry, only: %i[show edit update destroy]
  authorize_resource

  def index
    @log_entries = vehicle.log_entries
  end

  # GET /log_entries/1 or /log_entries/1.json
  def show; end

  # GET /log_entries/new
  def new
    @log_entry = vehicle.log_entries.new
  end

  # GET /log_entries/1/edit
  def edit; end

  # POST /log_entries or /log_entries.json
  def create
    @log_entry = vehicle.log_entries.new(log_entry_params)

    respond_to do |format|
      if @log_entry.save
        format.html { redirect_to log_entry_url(@log_entry), notice: I18n.t('log_entry.create.success') }
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
        format.html { redirect_to log_entry_url(@log_entry), notice: I18n.t('log_entry.update.success') }
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
      format.html { redirect_to vehicle_path(@log_entry.vehicle), notice: I18n.t('log_entry.destroy.success') }
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
    params
      .require(:log_entry)
      .permit(:title,
              :description,
              :cost,
              :recorded_mileage,
              :performed_on,
              :has_paper_record)
  end

  attr_accessor :vehicle
end
