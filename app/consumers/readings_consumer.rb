class ReadingsConsumer < Racecar::Consumer
  subscribes_to "readings"

  def process(message)
    payload = JSON.parse(message.value)
    process_reading(payload["reading"])
  rescue JSON::ParserError => e
    Rails.logger.error "Invalid JSON message: #{e.message}"
  rescue StandardError => e
    Rails.logger.error "Error processing Kafka message: #{e.message}"
  end

  private

  def process_reading(reading_data)
    reading = Reading.new(reading_data)
    if reading.save
      Rails.logger.info "IoT reading saved successfully! #{reading.inspect}"
    else
      Rails.logger.error "Failed to save reading: #{reading.errors.full_messages.join(', ')}"
    end
  end
end