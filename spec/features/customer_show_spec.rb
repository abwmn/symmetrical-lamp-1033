require 'rails_helper'

RSpec.describe "Customer Show Page", type: :feature do
  before(:each) do 
    @customer = Customer.create!(name: "Sally")
    @supermarket = Supermarket.create!(name: "Giant")
    @item1 = Item.create!(name: "Banana", price: 1, supermarket: @supermarket)
    @item2 = Item.create!(name: "Apple", price: 2, supermarket: @supermarket)
    @item3 = Item.create!(name: "Pineapple", price: 3, supermarket: @supermarket)
    @customer.customer_items.create!(item: @item1) 
    @customer.customer_items.create!(item: @item2) 
  end
  
  it "US1: I see customer's name and list of their items" do
    visit "customers/#{@customer.id}"

    expect(page).to have_content(@customer.name)

    within("ul#items") do
      expect(page).to have_content("Name: #{@item1.name}")
      expect(page).to have_content("Name: #{@item2.name}")
      expect(page).to have_content("Price: #{@item1.price}")
      expect(page).to have_content("Price: #{@item2.price}")
      expect(page).to have_content("Supermarket: #{@item1.supermarket_name}")
      expect(page).to have_content("Supermarket: #{@item2.supermarket_name}")
    end
  end

  it "US2: I see a form to add an existing item to customer" do
    visit "customers/#{@customer.id}"

    expect(page).not_to have_content("Name: #{@item3.name}")

    fill_in "Item ID:", with: @item3.id
    click_button "Add Item"

    expect(current_path).to eq("/customers/#{@customer.id}")
    
    within("ul#items") do
      expect(page).to have_content("Name: #{@item3.name}")
      expect(page).to have_content("Price: #{@item3.price}")
      expect(page).to have_content("Supermarket: #{@item3.supermarket_name}")
    end
  end
end
