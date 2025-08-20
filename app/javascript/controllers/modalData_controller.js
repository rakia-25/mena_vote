import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "candidateCode", "candidateName", "candidateCategory" ];

  connect() {
    document.addEventListener('DOMContentLoaded', this._retrieveQueryParam.bind(this));
  }
  
  initValue(e) {
    e.preventDefault();
    var datasetValue = this.element.dataset;
    var candidateCode = datasetValue.candidateCode;
    var candidateName = datasetValue.candidateName;
    var candidateCategory = JSON.parse(datasetValue.candidateCategory);
    this._intData({name: candidateName, categories: candidateCategory}, candidateCode);
  }

  _retrieveQueryParam() {
    const params = new URLSearchParams(window.location.search);
    const codequeryParam = params.get('code');

    if (codequeryParam) {
      fetch(`/candidates/candidate_name?vote_code=${codequeryParam}`)
        .then(response => response.json())
        .then(response => {
          this.candidateCodeTarget.value = codequeryParam;
          this.candidateNameTarget.value = response.candidate_name;
          this.candidateCategoryTarget.value = response.candidate_category;
          
          this._intData(response, codequeryParam);
        })
        .catch(error => {
          console.log(error, 'error')
        });
    }
  }

  _intData(candidate, codequeryParam) {
    document.querySelectorAll('.candidate-name').forEach(el => {
      el.textContent = candidate.name;
    });
    document.querySelectorAll('.candidate-category').forEach(el => {
      const categoryNames = candidate.categories.map(cat => cat.name).join(', ');
      el.textContent = categoryNames;
    });
    document.querySelector('.input-candidate-code').value = codequeryParam;
    document.querySelector('.clip-board-input-to-change').value = `${window.location.origin}/candidates/${codequeryParam}`;
  }
}
