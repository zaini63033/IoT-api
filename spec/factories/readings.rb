FactoryBot.define do
    factory :reading do
        device_id {"device123"}
        sequence(:reading_id) {|n| "reading#{n}"}
        ts {Time.current}
        metrics{{"temperature" => 25.0, "humidity" => 60}}
    end
endrail