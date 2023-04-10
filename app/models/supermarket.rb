class Supermarket < ApplicationRecord
  has_many :items

  def unique_customers
    Customer.joins(:items)
    .where(items: { supermarket_id: self.id })
    .distinct
  end
end