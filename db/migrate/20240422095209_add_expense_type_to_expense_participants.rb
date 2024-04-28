class AddExpenseTypeToExpenseParticipants < ActiveRecord::Migration[6.1]
  def change
    add_column :expense_participants, :expense_type, :string
  end
end
