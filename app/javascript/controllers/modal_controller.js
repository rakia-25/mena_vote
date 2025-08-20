import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "content" ];

  connect() {
    const showButton = this.element.querySelector('.show-button');
    showButton.addEventListener('click', this.show.bind(this));
    document.addEventListener('DOMContentLoaded', this._retrieveQueryParam.bind(this));
  }

  disconnect() {
    document.removeEventListener("DOMContentLoaded", this._retrieveQueryParam.bind(this));
  }
  
  show(e) {
    e.preventDefault();
    this.contentTarget.classList.add('is-active');
  }

  close(e) {
    e.preventDefault();
    this._deleteQueryParam();
    this.contentTarget.classList.remove('is-active');
  }

  _retrieveQueryParam() {
    const params = new URLSearchParams(window.location.search);
    const codequeryParam = params.get('code');
    if (codequeryParam) {
      this.contentTarget.classList.add('is-active');
    }
  }

  _deleteQueryParam() {
    const url = new URL(window.location.href);
    url.searchParams.delete('code');
    window.history.replaceState({}, document.title, url);
  }
}
