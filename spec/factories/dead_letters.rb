FactoryBot.define do
  factory :dead_letter do
    payload { "MyText" }
    error { "MyString" }
    topic { "MyString" }
    partition { 1 }
    offset { 1 }
  end
end
