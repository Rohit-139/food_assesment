import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

import { createOrderChat } from "channels/order_chat_channel"

let subscription

window.startChat = (orderId) => {
  subscription = createOrderChat(orderId)
}

window.sendMessage = () => {
  const input = document.getElementById("message_input")
  subscription.send_message(input.value)
  input.value = ""
}


export { application }
