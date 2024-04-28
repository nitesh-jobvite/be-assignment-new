FactoryBot.define do
  factory :expense do
    association :user
    total_amount { 100 }
    tax_amount { 0.0 }
    description { "Expense description" }
  end
end
