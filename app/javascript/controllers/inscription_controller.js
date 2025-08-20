import { Controller } from "@hotwired/stimulus"
export default class extends Controller {
  static targets = ['step','formStep',"currentPayment", "currentResponse", "submit", "loading",
                     'approvalStep', 'approved', 'loadingMobile', 'loadingAlizza', 'anyPaymentLoading']

  connect() {
    document.addEventListener("payment:succeed", this.updatePayment.bind(this));
    this.paymentOption = 'mobile';
  }

  updatePaymentOption(e) {
    this.paymentOption = e.currentTarget.getAttribute('for');
  }

  updatePayment(e) {
    console.log(this.currentPaymentTarget.value);

    if (this.currentPaymentTarget.value != e.detail.payment_uid) { return; }

    const status = e.detail.status;

    if (status == 'success') {
      document.querySelector('#payment_success').setAttribute("id", `payment_success_${e.detail.payment_id}`)
      this._displayStep("currentResponse");
    }

    if (status == 'failed') {
      document.querySelector('#payment_failed').setAttribute("id", `payment_failed_${e.detail.payment_id}`)
      this._displayStep("currentResponse");
    }
  }

  onPostSuccess(e) {
    const [data] = e.detail;
    // const results = data.payment;
    window.location.replace(data.checkout)
    // if(results.hasOwnProperty('provider') && results.provider == "mobile"){
    //   this.loadingMobileTarget.classList.remove('is-hidden');
    //   this.submitTarget.classList.add('is-hidden');
    // } else if(results.hasOwnProperty('provider')){
    //   this.loadingAlizzaTarget.classList.remove('is-hidden');      
    //   document.querySelector(".reference-alizza").textContent = results.public_reference
    //   this.submitTarget.classList.add('is-hidden');        
    // } else{
    //   this._displayStep("currentResponse");
    //   this.anyPaymentLoadingTarget.classList.remove('is-hidden');
    // }
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

  approveTerms(e){
    this.approvedTarget.value = true
    this._displayStep("formStep");
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
