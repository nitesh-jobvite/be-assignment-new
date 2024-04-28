FactoryBot.define do
  factory :expense_participant do
    association :user
    association :expense
    amount_paid { 50.0 } 
    expense_type { "borrower" }
  end
end
