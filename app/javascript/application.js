// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

import "trix"
import "@rails/actiontext"

import LocalTime from "local-time"
LocalTime.start()

import { showToast } from "toast"

window.showToast = showToast

// Show flash messages if they exist
document.addEventListener("turbo:load", () => {
  const flash = document.querySelector("p.notice, p.alert")
  if (flash) {
    showToast(flash.textContent)
    flash.remove()
  }
})
