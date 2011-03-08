FactoryGirl.define do
  factory :category do
    sequence(:name) {|n| "category #{n}" }
    sequence(:short_name) {|n| "category #{n}" }
  end
end