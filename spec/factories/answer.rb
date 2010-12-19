FactoryGirl.define do
  factory :answer do
    sequence(:content) {|n| "answer #{n}" }
  end
end