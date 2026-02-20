import consumer from "./consumer"

export const createOrderChat = (orderId) => {
  return consumer.subscriptions.create(
    { channel: "OrderChatChannel", order_id: orderId },
    {
      connected() {
        console.log("Connected to chat")
      },

      received(data) {
        console.log("Message:", data)
      },

      send_message(message) {
        this.perform("receive", { message: message })
      }
    }
  )
}
