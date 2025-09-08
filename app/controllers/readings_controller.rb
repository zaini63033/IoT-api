class ReadingsController < ApplicationController
  # def create
  #   @reading = Reading.new(reading_params)

  #   if @reading.save
  #     render json: { message: "IoT reading saved successfully!", data: @reading }, status: :created
  #   else
  #     render json: { message: @reading.errors.full_messages }, status:  :unprocessable_entity
  #   end
  # end

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

  def get_device_summary
    device_id = params[:device_id]
    window = params[:window]

    time_from = 0

    if window.present?
      hours = window.match(/(\d+)h/)[1].to_i rescue 24
      time_from = Time.now - hours.hours
    end

    readings = Reading.where(device_id: device_id).where("ts>= ?", time_from)

    if readings.exists?
      min_temp = Float::INFINITY
      avg_temp = 0
      max_temp = -Float::INFINITY

      min_humid = Float::INFINITY
      avg_humid = 0
      max_humid = -Float::INFINITY

      readings.each do |reading|
        metrics = reading["metrics"]
        temp = metrics["temperature"]
        humid = metrics["humidity"]

        avg_temp += temp
        avg_humid += humid 

        if(temp < min_temp)
          min_temp = temp;
        end

        if(humid < min_humid)
          min_humid = humid
        end

        if(temp > max_temp)
          max_temp = temp;
        end

        if(humid > max_humid)
          max_humid = humid
        end



      end

      avg_temp /= readings.size
      avg_humid /= readings.size

      render json: {
      device_id: device_id,
      hours: hours,
      count: readings.count,
      readings: readings,
      temperature:
      {
        min: min_temp,
        avg: avg_temp,
        max: max_temp,
      },
      humidity:
      {
        min: min_humid,
        avg: avg_humid,
        max: max_humid,
      }
    }, status: :ok
    end

  end

  private

  def reading_params
    params.require(:reading).permit(:device_id, :reading_id, :ts, metrics: [ :temperature, :humidity ])
  end
end
