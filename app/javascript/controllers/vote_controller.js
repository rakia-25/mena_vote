import { Controller } from "@hotwired/stimulus";
// import StimulusReflex from 'stimulus_reflex';

export default class extends Controller {

  initialize() {
    // StimulusReflex.register(this);
  }

  newVote(e) {
    e.stopPropagation();
    document.getElementById(`candidate-${e.detail.id}-votes`).textContent = e.detail.votes;
  }
}
