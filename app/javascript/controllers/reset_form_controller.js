import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  reset() {
    this.element.reset()
  }

  connect() {
    console.log('connect')
  }
}

console.log('we are here')