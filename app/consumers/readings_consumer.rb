class ReadingsConsumer < Racecar::Consumer
  subscribes_to "readings"

  def process(message)
    payload = JSON.parse(message.value)
    process_reading(payload["reading"])
  rescue JSON::ParserError => e
    log_and_store_dead_letter(message, e.message)
  rescue StandardError => e
    log_and_store_dead_letter(message, e.message)
  end

  private

  def process_reading(reading_data)
    reading = Reading.new(reading_data)
    if reading.save
      Rails.logger.info "IoT reading saved successfully! #{reading.inspect}"
    else
      log_and_store_dead_letter(nil, reading.errors.full_messages.join(', '))
    end
  end

  def log_and_store_dead_letter(message, error)
    Rails.logger.error "Dead-letter: #{error}"
    DeadLetter.create(
      payload: message&.value,
      error: error,
      topic: message&.topic,
      partition: message&.partition,
      offset: message&.offset
    )
  end
end