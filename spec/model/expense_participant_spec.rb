require 'rails_helper'

RSpec.describe ExpenseParticipant, type: :model do
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }
  let(:expense) { create(:expense, user: user1) }

  describe ".owes_you" do
    it "returns participants who owe the current user" do
      participant1 = create(:expense_participant, expense: expense, user: user2)
      participant2 = create(:expense_participant, expense: expense, user: user1)

      expect(ExpenseParticipant.owes_you(user1)).to eq([participant1])
    end
  end

  describe ".you_owe" do
    it "returns participants that the current user owes" do
      participant1 = create(:expense_participant, expense: expense, user: user1, expense_type: "borrower")
      participant2 = create(:expense_participant, expense: expense, user: user2, expense_type: "borrower")

      expect(ExpenseParticipant.you_owe(user1)).to eq([participant1])
    end
  end
end
