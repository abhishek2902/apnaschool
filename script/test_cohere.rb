require_relative '../app/services/cohere_service'
require 'dotenv/load'  # to load .env file (install `dotenv` gem)

# Set this in your .env file or directly in ENV
# ENV['COHERE_API_KEY'] = "your_actual_key_here"

puts "Ask a question:"
question = gets.chomp

answer = CohereService.get_answer(question)
puts "AI Answer: #{answer}"
