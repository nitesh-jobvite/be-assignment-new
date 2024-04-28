class TransactionsController < ApplicationController
  def new
    @transaction = Transaction.new
    @users = User.where.not(id: current_user.id)
  end

  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.payer = current_user

    if @transaction.save
      redirect_to root_path, notice: "Settlement was successfully created."
    else
      render :new
    end
  end

  private

  def transaction_params
    params.permit(:receiver_id, :amount, :notes)
  end
end