require 'rails_helper'

RSpec.describe Reading, type: :model do
    subject { build(:reading) }

    it "is valid with valid attributes" do
        expect(subject).to be_valid
    end

    it "is invalid (without device_id)" do
        subject.device_id = nil
        expect(subject).not_to be_valid
        expect(subject.errors[:device_id]).to include("can't be blank")
    end

    it "is invalid (without reading_id)" do
        subject.reading_id = nil
        expect(subject).not_to be_valid
    end
    
    it "must have unique reading_id" do
        create(:reading, reading_id: "reading123")
        duplicate = build(:reading, reading_id: "reading123")
        expect(duplicate).not_to be_valid
        expect(duplicate.errors[:reading_id]).to include("has already been taken")
    end

    it "must have metrics" do
        subject.metrics = nil
        expect(subject).not_to be_valid

        subject.metrics = {}
        expect(subject).not_to be_valid
    end

    it "must have valid temperature" do
        subject.metrics = {"temperature" => "invalid", "humidity" => 50}
        expect(subject).not_to be_valid
    end

    it "must have valid humidity" do
        subject.metrics = {"temperature" => 25.5, "humidity" => "invalid"}
        expect(subject).not_to be_valid

        subject.metrics = {"temperature" => 25.5, "humidity" => 110}
        expect(subject).not_to be_valid
    end
end