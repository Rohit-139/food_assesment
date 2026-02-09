module ApplicationHelper
   def dish_in_cart?(dish)
  current_user.cart.cart_items.exists?(dish_id: dish.id)
end
end
