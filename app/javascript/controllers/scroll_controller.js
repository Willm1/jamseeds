import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="scroll"
export default class extends Controller {
  connect() {
    this.element.addEventListener("DOMNodeInserted", this.#resetScroll);
    this.#resetScroll();
  }

  disconnect() {
    console.log("Disconnected");
  }

  #resetScroll() {
    // messages.scrollTop = messages.scrollHeight - messages.clientHeight;
    let temp = document.querySelector(".messages-container");

    console.log("Should be scrolling");
    temp.scrollTo(0, temp.scrollHeight);
  }
}
