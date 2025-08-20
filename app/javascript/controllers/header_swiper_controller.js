import { Controller } from "@hotwired/stimulus";
import Swiper from 'swiper';
import {Autoplay, Navigation, Pagination } from 'swiper/modules';

export default class extends Controller {
  connect() {
    const progressCircle = this.element.querySelector(".autoplay-progress svg");
    const progressContent = this.element.querySelector(".autoplay-progress span");

    const swiper = new Swiper(this.element, {
      modules: [Autoplay, Navigation, Pagination],
      spaceBetween: 30,
      centeredSlides: true,
      slidesPerView: "auto",
      autoplay: {
        delay: 2500,
        disableOnInteraction: false
      },
      pagination: {
        el: ".swiper-pagination",
        clickable: true
      },
      navigation: {
        nextEl: ".swiper-button-next",
        prevEl: ".swiper-button-prev"
      },
      on: {
        autoplayTimeLeft: (swiper, time, progress) => {
          progressCircle.style.setProperty("--progress", 1 - progress);
          progressContent.textContent = `${Math.ceil(time / 1000)}s`;
        }
      }
    });
  }
}
