class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :expenses
  has_many :transactions, foreign_key: :payer_id
  has_many :received_transactions, class_name: "Transaction", foreign_key: :receiver_id
  has_many :expense_participants

  def amount_owed_to_you
    amount_paid_by_others = received_transactions.sum(:amount)
    expenses = Expense.where(user_id: id)
    expense_participants_owes_you = ExpenseParticipant.where(expense_id: expenses.pluck(:id)).where.not(user_id: id)
    amount_owed_from_expenses = expense_participants_owes_you.sum(:amount_paid)

    amount_paid_to_others = transactions.sum(:amount)

    amount_paid_to_others + amount_owed_from_expenses
  end

  def amount_you_owe
    amount_paid_by_others = received_transactions.sum(:amount)
    expense_participants_you_owes = expense_participants.where(expense_type: "borrower")
    amount_you_owe_from_expenses = expense_participants_you_owes.sum(:amount_paid)

    amount_you_owe_from_expenses + amount_paid_by_others
  end

  def total_balance
    amount_owed_to_you - amount_you_owe
  end
end
