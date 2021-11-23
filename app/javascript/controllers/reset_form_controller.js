import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  reset() {
    console.log("SHOULD RESET");
    location.reload(true);
    this.element.reset();
    console.log("RESET...");
  }

  connect() {
    console.log("connect");
  }
}

console.log("we are here");
