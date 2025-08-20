import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [ "timer" ]

  connect() {
    this.updateTime()
    this.timer = setInterval(() => this.updateTime(), 1000)
  }

  disconnect() {
    clearInterval(this.timer)
  }

  updateTime() {
    fetch('/current_time')
      .then(response => response.json())
      .then(data => {
        const currentTime = new Date(data.current_time)
        const nextMidnight = new Date(currentTime)
        nextMidnight.setHours(23, 30, 0, 0)

        if (currentTime >= nextMidnight) {
          nextMidnight.setDate(nextMidnight.getDate() + 1)
        }

        const timeDiff = nextMidnight - currentTime
        const hours = Math.floor(timeDiff / (1000 * 60 * 60))
        const minutes = Math.floor((timeDiff % (1000 * 60 * 60)) / (1000 * 60))
        const seconds = Math.floor((timeDiff % (1000 * 60)) / 1000)

        if (timeDiff <= 0) {
          clearInterval(this.timer)
        } else {
          this.timerTarget.innerHTML = `${this.pad(hours)}h:${this.pad(minutes)}:${this.pad(seconds)}`
        }
      })
  }

  pad(number) {
    return number < 10 ? '0' + number : number
  }
}
