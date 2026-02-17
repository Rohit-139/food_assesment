class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :dish

  before_validation :set_default_quantity

  private
  def set_default_quantity
    self.quantity ||= 1
  end
end
