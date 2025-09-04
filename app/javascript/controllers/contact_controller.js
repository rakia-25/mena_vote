import { Controller } from "@hotwired/stimulus"
export default class extends Controller {
  static targets = [ 'success', 'error', 'form', 'email', 'fullname', 'message' ]

  connect() {
  }

  onPostError(e) {
    this.errorTarget.classList.remove('is-hidden');
  }

  onPostSuccess(e) {
    this.errorTarget.classList.add('is-hidden');
    this.formTarget.classList.add('is-hidden');
    this.successTarget.classList.remove('is-hidden');
    window.location = `mailto:menador.niger@gmail.com?subject=${this.fullnameTarget.value} - MissNiger&body= ${this.messageTarget.value}
    &cc=${this.emailTarget.value}`;
  }

}
