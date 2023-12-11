import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {
  open(event) {
    const button = event.currentTarget;
    const modalId = button.getAttribute('data-target');
    const modal = new bootstrap.Modal(document.getElementById(modalId));
    modal.show();
  }
}

