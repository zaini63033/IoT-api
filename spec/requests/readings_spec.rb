require 'rails_helper'

RSpec.describe "Readings API", type: :request do
    # describe "POST /readings" do
    #     let(:valid_payload) do
    #         {
    #             reading: {
    #                 device_id: "device123",
    #                 reading_id: "reading000",
    #                 ts: Time.current,
    #                 metrics: {temperature: 24.5, humidity: 60}
    #             }
    #         }
    #     end

    #     it "creates valid data" do
    #         post "/readings", params: valid_payload.to_json, headers: { "CONTENT_TYPE" => "application/json" }
    #         expect(response).to have_http_status(:created)
    #         body = JSON.parse(response.body)
    #         expect(body["data"]["device_id"]).to eq("device123")
    #     end

    #     it "returns error for invalid data" do
    #         invalid = valid_payload.deep_dup
    #         invalid[:reading][:metrics][:humidity] = 200
    #         post "/readings", params: valid_payload.to_json, headers: { "CONTENT_TYPE" => "application/json" }
    #         expect(response).to have_http_status(:unprocessable_entity)
    #         body = JSON.parse(response.body)
    #         expect(body["errors"].present?).to be true
    #     end
    # end

    describe "GET /devices/:device_id/readings" do
        # before do
        #     create_list(:reading, 3, device_id: "device_001")
        #     create(:reading, device_id: "device999")
        # end

        it "returns readings limited by limit param" do
            get "http://localhost:3000/devices/device123/readings?limit=2"
            expect(response).to have_http_status(:ok)
            body = JSON.parse(response.body)
            expect(body["readings"].length).to be <= 2
            expect(body["device_id"]).to eq("device123")

        end
    end

    describe "GET /devices/:device_id/summary" do
        # before do
        #     create_list(:reading, 3, device_id: "device_001")
        #     create(:reading, device_id: "device999")
        # end

        it "returns readings summary within window param" do
            puts "Reading count: #{Reading.count}"
            for reading in Reading.all do
                puts reading.device_id, reading.reading_id, reading.metrics
            end

            get "http://127.0.0.1:3000/devices/device123/summary"
            expect(response).to have_http_status(:ok)
            body = JSON.parse(response.body)
            expect(body["device_id"]).to eq("device123")

        end
    end


end