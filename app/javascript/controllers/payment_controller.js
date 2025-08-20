import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "total", "paymentPhone", "paymentService", "voteNumber", "voteCode", "paymentPhoneError", "button", "amountError" ];
  
  cost(e) {
    e.preventDefault();
    const total = this.voteNumberTarget.value * 100 || '100';
    this.totalTarget.innerHTML = `${total} F cfa`;
  }
  
  resquestPayment() {
    const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content')

    if (this.voteNumberTarget.value <= 0) {
      this.amountErrorTarget.classList.remove('is-hidden');
      return;
    } else {
      this.amountErrorTarget.classList.add('is-hidden');
    }

    var myHeaders = new Headers();
    myHeaders.append("Content-Type", "application/json");
    myHeaders.append("X-CSRF-Token", csrfToken);

    var raw = JSON.stringify({
      "payment": {
        "vote_number": this.voteNumberTarget.value || 1,
        "vote_code": this.voteCodeTarget.value,
      }
    });

    var requestOptions = {
      method: 'POST',
      headers: myHeaders,
      body: raw,
    };

    this._toggleButtonLoading();
    fetch("/payments", requestOptions)
      .then(response => response.json())
      .then(response => {
        window.location.replace(response.checkout);
      })
      .catch(error => {
        console.log(error, 'error')
      });
  }

  _toggleButtonLoading() {
    this.buttonTarget.classList.toggle('is-loading')
  }
}
