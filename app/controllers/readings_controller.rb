class ReadingsController < ApplicationController
  def create
    @reading = Reading.new(reading_params)

    if @reading.save
      render json: { message: "IoT reading saved successfully!", data: @reading }, status: :created
    else
      render json: { message: @reading.errors.full_messages }
    end
  end

  private

  def reading_params
    params.require(:reading).permit(:device_id, :reading_id, :ts, metrics: [ :temperature, :humidity ])
  end
end
