require 'rails_helper'

RSpec.describe "Items Index Page", type: :feature do
  before(:each) do 
    @supermarket = Supermarket.create!(name: "Giant")
    @item1 = Item.create!(name: "Banana", price: 1, supermarket: @supermarket)
    @item2 = Item.create!(name: "Apple", price: 2, supermarket: @supermarket)
    @customer1 = Customer.create!(name: "Sally")
    @customer2 = Customer.create!(name: "John")
    
    @customer1.customer_items.create!(item: @item1)
    @customer1.customer_items.create!(item: @item2)
    @customer2.customer_items.create!(item: @item2)
  end
  
  it "US3: I see a list of all items with their details and customer count" do
    visit items_path

    within("ul#items") do
      expect(page).to have_content("Name: #{@item1.name}")
      expect(page).to have_content("Price: #{@item1.price}")
      expect(page).to have_content("Supermarket: #{@item1.supermarket_name}")
      expect(page).to have_content("Customer Count: 1")

      expect(page).to have_content("Name: #{@item2.name}")
      expect(page).to have_content("Price: #{@item2.price}")
      expect(page).to have_content("Supermarket: #{@item2.supermarket_name}")
      expect(page).to have_content("Customer Count: 2")
    end
  end
end
