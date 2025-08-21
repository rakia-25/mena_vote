import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal", "amountInput", "ipayButton", "amountInputErrorMessage"];

  open() {
    this.modalTarget.classList.add('is-active');
  }

  close() {
    this.modalTarget.classList.remove('is-active');
  }

  updateAmount() {
    const amount = this.amountInputTarget.value;
    this.ipayButtonTarget.dataset.amount = amount;
  }

  submitForm() {
    if (this.amountInputTarget.value == '') {
      this.amountInputErrorMessageTarget.classList.remove('is-hidden');
      return;
    }
    const amount = this.amountInputTarget.value;
    this.amountInputTarget.value = '';
    const transactionId = `menavote_donate_${new Date().toISOString()}`;
    this.ipayButtonTarget.dataset.amount = amount;
    this.ipayButtonTarget.dataset.transactionId = transactionId;
    this.amountInputErrorMessageTarget.classList.add('is-hidden');
    this.ipayButtonTarget.click();
    this.close();
  }
}
