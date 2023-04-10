class CustomersController < ApplicationController
  def show
    @customer = Customer.find(params[:id])
  end  

  def add_item
    @customer = Customer.find(params[:id])
    item = Item.find(params[:item_id])

    @customer.items << item
    redirect_to customer_path(@customer)
  end
end
