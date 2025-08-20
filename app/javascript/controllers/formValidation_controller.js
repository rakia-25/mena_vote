import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["submit", "loading",'step','formStep', "approvalStep","currentPayment", "currentResponse", "approved" ]

  connect() {
  }

  disconnect() {
  }

  onPostError(e) {
    const [data] = e.detail;
    const errors  = data.errors;

    this._resetErrorFields();

    for (var key in errors) {
      const errorField = this.element.querySelector(`.help.${key}_error`);
      if (errorField) {
        errorField.textContent = errors[key].join(', ');
      }
    }
  }

  onPostSuccess(e){
    // this.loadingTarget.classList.remove('is-hidden');
    // this.submitTarget.classList.add('is-hidden');
    this._displayStep("currentResponse");
  }

  _displayStep(step) {
    this.stepTargets.forEach(elt => elt.classList.add('is-hidden'));
    this[`${step}Target`].classList.remove('is-hidden');
  }

  _resetErrorFields() {
    Array.from(this.element.getElementsByClassName('help is-danger')).forEach(function(elt){
      elt.textContent = "";
    });
  }
}


