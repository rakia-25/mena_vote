import { Controller } from "stimulus";
import * as clipboard from "clipboard-polyfill/text";

export default class extends Controller {
  static targets = [ "candidateCode", "source" ]

  connect() {
    if (document.queryCommandSupported("copy")) {
      this.element.classList.add("clipboard--supported");
    }
  }

  copy(e) {
    e.preventDefault();
    var candidateCode = document.querySelector('.input-candidate-code').value || this.candidateCodeTarget.value;
    clipboard.writeText(`${window.location.origin}/candidates/${candidateCode}`);
    e.currentTarget.setAttribute('data-tooltip', 'Copié dans le presse-papiers');
  }
}
