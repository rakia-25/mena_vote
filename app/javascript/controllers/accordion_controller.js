import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [ "content" ];

  toggle(e) {
    e.preventDefault();
    this.contentTarget.classList.toggle('is-active');
  }
}
