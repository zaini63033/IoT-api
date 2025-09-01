class Reading < ApplicationRecord
  validates :device_id, presence: true
  validates :reading_id, presence: true, uniqueness: true
  validates :ts, presence: true

  validate :validate_metrics

  private

  def validate_metrics
    if metrics.blank?
      errors.add(:metrics, "can't be empty!")
      return
    end

    unless metrics.key?("temperature") && metrics.key?("humidity")
      errors.add(:metrics, "must have both temperature and humidity!")
    end

    unless metrics["temperature"].is_a?(Numeric)
      errors.add(:metrics, "must have a numeric temperature!")
    end

    unless metrics["humidity"].is_a?(Numeric) && metrics["humidity"] >= 0 && metrics["humidity"] <= 100
      errors.add(:metrics, "must have a valid humidity!")
    end
  end
end
