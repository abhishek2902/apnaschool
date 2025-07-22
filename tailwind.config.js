/** @type {import('tailwindcss').Config} */
module.exports = {
    darkMode: "class", // Enable class-based dark mode
    content: [
      "./app/views/**/*.html.erb",
      "./app/helpers/**/*.rb",
      "./app/javascript/**/*.js",
    ],
    theme: {
      extend: {},
    },
    plugins: [],
    options: {
      safelist: ['ml-4', 'm-6'], // Ensure these classes are not removed
    }
  };
  