import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["submit"]

  submit() {
    const element = this.submitTarget;
    element.value = "Signing in..."
    element.classList.add('submit-disabled');
    element.classList.remove('submit-enabled');
  }
}
