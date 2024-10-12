import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    console.log("conn");
    const messages = document.getElementById("messages");
    messages.addEventListener("DOMNodeInsertion", this.resetScroll);
    this.resetScroll(messages);
  }
  disconnect() {
    console.log("disconn");
  }

  resetScroll() {
    messages.scrollTop = messages.scrollHeight - messages.clientHeight;
  }
}
