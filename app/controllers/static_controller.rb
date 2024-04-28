class StaticController < ApplicationController
  def dashboard
    @transactions = Transaction.where('payer_id = :user_id OR receiver_id = :user_id', user_id: current_user.id)
    @users = User.all
    @amount_owed_to_you = current_user.amount_owed_to_you
    @amount_you_owe = current_user.amount_you_owe
    @total_balance = current_user.total_balance
    @friends = Expense.friends_for_user(current_user.id)
    @expenses = current_user.expenses
    @expense_participants_owes_you = ExpenseParticipant.owes_you(current_user)
    @expense_participants_you_owes = ExpenseParticipant.you_owe(current_user)
  end

  def person
    @id = params[:id]
    @expenses = Expense.where(user_id: @id)
  end
end
