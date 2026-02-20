class OrderChatChannel < ApplicationCable::Channel
  def subscribed
    @order = Order.find(params[:order_id])

    unless allowed_user?
      reject
      return
    end

    stream_for @order
  end

  def receive(data)
    message = @order.messages.create!(
      content: data["message"],
      user: current_user
    )

    OrderChatChannel.broadcast_to(@order, {
      message: message.content,
      user: current_user.name
    })
  end

  private

  def allowed_user?
    current_user.id == @order.user_id ||
    current_user.id == @order.restaurant.owner_id
  end
end
