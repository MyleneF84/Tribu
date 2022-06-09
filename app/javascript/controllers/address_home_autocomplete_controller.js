import { Controller } from "@hotwired/stimulus"
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder"

export default class extends Controller {
  static values = { apiKey: String }
  static targets = ["city"]

  connect() {
    this.geocoder = new MapboxGeocoder({
      accessToken: this.apiKeyValue,
      types: "country,region,place,postcode,locality",
      placeholder: "Ville, commune, région"
    })
    this.geocoder.addTo(this.element)
    this.geocoder.on("result", event => this.#setInputValue(event))
    this.geocoder.on("clear", () => this.#clearInputValue())

    this.geocoder._inputEl.value = this.cityTarget.value;
  }

  #setInputValue(event) {
    this.cityTarget.value = event.result["text"]
  }

  #clearInputValue() {
    this.cityTarget.value = ""
  }

}
