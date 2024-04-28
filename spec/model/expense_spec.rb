require 'rails_helper'

RSpec.describe Expense, type: :model do
  describe "#create_expense_participants" do
    let(:user) { create(:user) }
    let(:expense) { create(:expense, user: user, total_amount: 100, tax_amount: 10) }
    let!(:participants) { create_list(:user, 2) }
    let(:participant_ids) { participants.map(&:id) }

    it "creates expense participants for each participant_id and the expense owner" do
      expect {
        Expense.create_expense_participants(expense, participant_ids)
      }.to change(ExpenseParticipant, :count).by(participant_ids.count + 1)
    end

    xit "calculates the amount paid for each participant correctly" do
      Expense.create_expense_participants(expense, participant_ids)
      expense.reload
      participant_ids.each do |participant_id|
        participant = expense.expense_participants.find_by(user_id: participant_id)
        expect(participant.amount_paid).to eq(expense.calculate_amount_paid(participant_id, participant_ids.count))
      end
    end
  end

  describe "#friends_for_user" do
    let(:user1) { create(:user) }
    let(:user2) { create(:user) }
    let(:user3) { create(:user) }
    let(:expense1) { create(:expense, user: user1) }
    let(:expense2) { create(:expense, user: user2) }
    let(:expense3) { create(:expense, user: user3) }

    before do
      create(:expense_participant, expense: expense1, user: user2)
      create(:expense_participant, expense: expense2, user: user1)
      create(:expense_participant, expense: expense3, user: user1)
      create(:expense_participant, expense: expense3, user: user2)
    end

    it "returns users who are involved in expenses with the given user" do
      friends = Expense.friends_for_user(user1.id)
      expect(friends).to include(user2)
      expect(friends).to_not include(user3)
    end
  end

  describe "#calculate_amount_paid" do
    let(:user) { create(:user) }
    let(:expense) { create(:expense, user: user, total_amount: 100, tax_amount: 10) }
    let(:participant_count) { 3 }

    it "calculates the amount paid correctly for a participant" do
      amount_paid = expense.calculate_amount_paid(user.id, participant_count)
      expect(amount_paid).to eq((expense.total_amount + expense.tax_amount.to_f) / (participant_count + 1))
    end
  end
end
