require 'rails_helper'

RSpec.describe "Supermarket Show Page", type: :feature do
  before(:each) do
    @supermarket = Supermarket.create!(name: "Giant")
    @other_supermarket = Supermarket.create!(name: "MiniMart")
    @customer1 = Customer.create!(name: "Sally")
    @customer2 = Customer.create!(name: "Bob")
    @customer3 = Customer.create!(name: "Tom")
    @item1 = Item.create!(name: "Banana", price: 1, supermarket: @supermarket)
    @item2 = Item.create!(name: "Apple", price: 2, supermarket: @supermarket)
    @item3 = Item.create!(name: "Orange", price: 3, supermarket: @other_supermarket)

    @customer1.customer_items.create!(item: @item1)
    @customer1.customer_items.create!(item: @item2)
    @customer2.customer_items.create!(item: @item2)
    @customer3.customer_items.create!(item: @item3)
  end

  it "I see a unique list of all customers that have shopped at the supermarket" do
    visit supermarket_path(@supermarket)

    within("ul#customers") do
      expect(page).to have_content(@customer1.name, count: 1)
      expect(page).to have_content(@customer2.name, count: 1)
      expect(page).not_to have_content(@customer3.name)
    end
  end
end
