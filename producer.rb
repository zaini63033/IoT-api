require "json"
require "kafka"

kafka = Kafka.new(
  seed_brokers: ["localhost:9092"]
)

producer = kafka.async_producer(
  delivery_interval: 1
)

reading_data_array = [
  {
    reading: {
      device_id: "device_001",
      reading_id: "reading_888",
      ts: Time.now,
      metrics: {
        temperature: "testing",
        humidity: "invalid"
      }
    }
  },
  {
    reading: {
      device_id: "device_001",
      reading_id: "reading_999",
      ts: Time.now,
      metrics: {
        temperature: 31,
        humidity: 20
      }
    }
  },
  {
    reading: {
      device_id: "device_001",
      reading_id: "reading_234",
      ts: Time.now,
      metrics: {
        temperature: 25.0,
        humidity: 61
      }
    }
  },
  {
    reading: {
      device_id: "device_001",
      reading_id: "reading_345",
      ts: Time.now,
      metrics: {
        temperature: 26.2,
        humidity: 59
      }
    }
  },
  {
    reading: {
      device_id: "device_002",
      reading_id: "reading_456",
      ts: Time.now,
      metrics: {
        temperature: 21.0,
        humidity: 75
      }
    }
  },
  {
    reading: {
      device_id: "device_002",
      reading_id: "reading_567",
      ts: Time.now,
      metrics: {
        temperature: 20.8,
        humidity: 76
      }
    }
  },
  {
    reading: {
      device_id: "device_003",
      reading_id: "reading_678",
      ts: Time.now,
      metrics: {
        temperature: 29.1,
        humidity: 45
      }
    }
  },
  {
    reading: {
      device_id: "device_003",
      reading_id: "reading_789",
      ts: Time.now,
      metrics: {
        temperature: 29.5,
        humidity: 46
      }
    }
  },
  {
    reading: {
      device_id: "device_003",
      reading_id: "reading_890",
      ts: Time.now,
      metrics: {
        temperature: 28.9,
        humidity: 44
      }
    }
  },
  {
    reading: {
      device_id: "device_004",
      reading_id: "reading_901",
      ts: Time.now,
      metrics: {
        temperature: 23.3,
        humidity: 68
      }
    }
  }
]

topic_name = "readings"

reading_data_array.each do |reading_data|
  message_payload = JSON.generate(reading_data)
  producer.produce(message_payload, topic: topic_name)
  puts "Sent message with reading_id: #{reading_data.dig(:reading, :reading_id)}"
end

producer.deliver_messages
producer.shutdown

puts "All messages have been sent to Kafka topic: '#{topic_name}'"
