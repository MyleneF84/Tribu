import { Controller } from "@hotwired/stimulus"
import autocomplete from 'js-autocomplete';

// Connects to data-controller="autocomplete"
export default class extends Controller {
  static values = { addresses: Array }
  static targets = ["searchInput"]

  connect() {
    // console.log(this.searchInputTarget)
    // console.log(this.addressesValue)

    const choices = this.addressesValue;

    new autocomplete({
      selector: this.searchInputTarget,
      minChars: 1,
      source: function(term, suggest){
          term = term.toLowerCase();
          const matches = [];
          for (let i = 0; i < choices.length; i++)
              if (~choices[i].toLowerCase().indexOf(term)) matches.push(choices[i]);
          suggest(matches);
      },
    });

  }
}
