class Expense < ApplicationRecord
  belongs_to :user
  has_many :expense_participants

  def self.create_expense_participants(expense, participant_ids)
    participant_count = participant_ids.count + 1
    participant_ids.uniq.each do |participant_id|
      ExpenseParticipant.create(user_id: participant_id, expense_id: expense.id, amount_paid: expense.calculate_amount_paid(participant_id, participant_count), expense_type: "borrower")
    end
    ExpenseParticipant.create(user_id: expense.user_id, expense_id: expense.id, amount_paid: expense.calculate_amount_paid(expense.user_id, participant_count), expense_type: "lender")
  end

  def self.friends_for_user(user_id)
    user_expense_ids = ExpenseParticipant.where(user_id: user_id).pluck(:expense_id)
    friend_ids = ExpenseParticipant.where(expense_id: user_expense_ids)
                                   .where.not(user_id: user_id)
                                   .pluck(:user_id)
                                   .uniq
    User.where(id: friend_ids)
  end

  def calculate_amount_paid(participant_id, participant_count)
    total_amount = self.total_amount + self.tax_amount.to_f
    shared_amount = total_amount / participant_count
    shared_amount
  end
end
