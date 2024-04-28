class ExpenseParticipant < ApplicationRecord
  belongs_to :user
  belongs_to :expense

  def self.owes_you(current_user)
    where(expense_id: current_user.expenses.pluck(:id)).where.not(user_id: current_user.id)
  end

  def self.you_owe(current_user)
    where(user_id: current_user.id, expense_type: "borrower")
  end
end
