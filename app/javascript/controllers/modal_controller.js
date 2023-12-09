import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {

  connect() {
    this.modal = new bootstrap.Modal(document.getElementById("confirmationModal"));
  }

  open() {
    this.modal.show();
  }

  close() {
    this.modal.hide();
  }
}

