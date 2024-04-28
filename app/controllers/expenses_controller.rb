class ExpensesController < ApplicationController
  def new
    @expense = Expense.new
  end

  def create
    @participant_ids = params.delete(:participant_ids).reject(&:blank?)
    @user = User.find_by(id: params[:user_id])
    @expense = @user.expenses.build(expense_params)
    if @expense.save
      Expense.create_expense_participants(@expense, @participant_ids)
      redirect_to @expense, notice: 'Expense was successfully created.'
    else
      render :new
    end
  end

  def show
    redirect_to root_path
  end

  private

  def expense_params
    params.permit(:total_amount, :description, :user_id, :tax_amount, :expense_type, participant_ids: [])
  end
end
