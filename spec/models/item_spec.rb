require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to :supermarket }
    it { should have_many :customer_items }
    it { should have_many :customers }
  end

  describe "#supermarket_name" do
    it "returns the supermarket name" do
      supermarket = Supermarket.create!(name: "Giant")
      item = Item.create!(supermarket: supermarket)

      expect(item.supermarket_name).to eq("Giant")
    end
  end
end
