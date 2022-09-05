import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="scroll"
export default class extends Controller {
  connect() {
    console.log("Connected");
    const messages = document.getElementById("messages");
    messages.addEventListener("DOMNodeInserted", this.resetScroll);
    this.resetScroll(messages);
  }

  disconnect() {
    console.log("Disconnected");
  }

  resetScroll(messages) {
    console.log("Trying to scroll");
    console.log(messages.scrollTop);
    console.log(messages.scrollHeight);
    console.log(messages.clientHeight);
    // messages.scrollTop = messages.scrollHeight - messages.clientHeight;
  }
}
