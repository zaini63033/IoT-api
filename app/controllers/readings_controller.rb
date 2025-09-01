class ReadingsController < ApplicationController
  def create
    @reading = Reading.new(reading_params)

    if @reading.save
      render json: { message: "IoT reading saved successfully!", data: @reading }, status: :created
    else
      render json: { message: @reading.errors.full_messages }
    end
  end

  def get_device_readings
    device_id = params[:device_id]
    limit = params[:limit]&.to_i || 50

    readings = Reading.where(device_id: device_id).order(ts: "desc").limit(limit)

    render json: {
      device_id: device_id,
      limit: limit,
      count: readings.count,
      readings: readings
    }, status: :ok
  end



  private

  def reading_params
    params.require(:reading).permit(:device_id, :reading_id, :ts, metrics: [ :temperature, :humidity ])
  end
end
