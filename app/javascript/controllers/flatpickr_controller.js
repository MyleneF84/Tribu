import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr"
import rangePlugin from "flatpickr/dist/plugins/rangePlugin"

// Connects to data-controller="flatpickr"
export default class extends Controller {
  static targets = ["rangeStart", "rangeEnd"]

  connect() {
    flatpickr(this.rangeStartTarget, {
      plugins: [new rangePlugin({ input: this.rangeEndTarget})],
      minDate: "today",
      dateFormat: "Y-m-d",
    })
  }
}
