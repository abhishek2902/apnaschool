
require 'http'

class CohereService
  def self.get_answer(question)
    api_key = ENV['COHERE_API_KEY']

    response = HTTP.auth("Bearer #{api_key}")
                   .post("https://api.cohere.ai/v1/chat", json: {
                     message: question,
                     model: "command-r", # free-tier chat model
                     temperature: 0.7
                   })

    result = JSON.parse(response.body.to_s) # json to ruby hash

    result.dig("text") || "Sorry, I couldn't find an answer."
  rescue => e
    Rails.logger.error "Cohere error: #{e.message}"
    "Sorry, something went wrong. Please try again later."
  end
end
