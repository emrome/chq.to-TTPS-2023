// app/javascript/controllers/filter_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["ipAddress", "endDate", "startDate"];

  connect() {
    this.element.addEventListener("submit", (event) => this.handleFormSubmit(event));
    this.element.addEventListener("change", (event) => this.toggleDateFields(event));
  }

  toggleDateFields(event) {
    const startDateInput = this.startDateTarget;
    const endDateInput = this.endDateTarget;

    const startDate = startDateInput.value;
    const endDate = endDateInput.value;

    this.startDateTarget.setAttribute("max", endDate);
    this.endDateTarget.setAttribute("min", startDate);
  }

  handleFormSubmit(event) {
    event.preventDefault();
    const params = {};
    if (this.ipAddressTarget.value.trim() !== "") {
      params["ip_address"] = this.ipAddressTarget.value;
    }
    if (this.startDateTarget.value.trim() !== "") {
      params["start_date"] = this.startDateTarget.value;
    }
    if (this.endDateTarget.value.trim() !== "") {
      params["end_date"] = this.endDateTarget.value;
    }
    const queryString = new URLSearchParams(params).toString();
    const url = this.element.action + (queryString ? `?${queryString}` : "");
    window.location.href = url;
  }
}
