// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

import "../stylesheets/application.tailwind.css"


document.addEventListener("DOMContentLoaded", function () {
    const toggleButton = document.getElementById("dark-mode-toggle");
    if (!toggleButton) return;
  
    // Check and apply saved theme
    if (localStorage.getItem("theme") === "dark") {
      document.documentElement.classList.add("dark");
    }
  
    toggleButton.addEventListener("click", function () {
      document.documentElement.classList.toggle("dark");
  
      // Save preference
      if (document.documentElement.classList.contains("dark")) {
        localStorage.setItem("theme", "dark");
      } else {
        localStorage.setItem("theme", "light");
      }
    });
  });
  