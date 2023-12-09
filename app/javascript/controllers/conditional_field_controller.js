import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="conditional-field"

export default class extends Controller {
  static targets = ["passwordField", "expirationDateField"];

  connect() {
    this.toggleFields();
  }

  toggleFields() {
    const selectedType = this.element.querySelector('[name="link[type]"]').value;

    if (selectedType === "PrivateLink") {
      this.passwordFieldTarget.style.display = "block";
      this.expirationDateFieldTarget.style.display = "none";
    } else if (selectedType === "TemporaryLink") {
      this.passwordFieldTarget.style.display = "none";
      this.expirationDateFieldTarget.style.display = "block";
    } else {
      this.passwordFieldTarget.style.display = "none";
      this.expirationDateFieldTarget.style.display = "none";
    }
  }
}