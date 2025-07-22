
require 'openai' # noneed
require 'net/http'
require 'json'
require 'uri'

class AiService
  def self.get_answer(question)
    if Rails.env.development?
        # 👉 Return a fake answer in dev mode
        return "This is a mocked AI answer to: '#{question}'"
    end

    api_key = ENV['OPENAI_API_KEY']
    return "API key not found." unless api_key

    uri = URI("https://api.openai.com/v1/chat/completions")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    headers = {
      "Content-Type" => "application/json",
      "Authorization" => "Bearer #{api_key}"
    }

    body = {
      model: "gpt-3.5-turbo",
      messages: [{ role: "user", content: question }],
      temperature: 0.7
    }

    response = http.post(uri.path, body.to_json, headers)

    # Debug log
    Rails.logger.info("AI RESPONSE: #{response.code} - #{response.body}")

    json = JSON.parse(response.body)
    json.dig("choices", 0, "message", "content")&.strip || "No response from AI."

  rescue => e
    Rails.logger.error("AI ERROR: #{e.class} - #{e.message}")
    "Sorry, something went wrong. Please try again later."
    
  end
end
