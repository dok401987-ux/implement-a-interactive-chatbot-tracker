# auuj_implement_a_int.rb

require 'yaml'
require 'json'

# Chatbot Tracker class
class ChatbotTracker
  def initialize
    @conversations = YAML.load_file('conversations.yaml') || {}
  end

  # Start a new conversation
  def start_conversation(user_name)
    @conversations[user_name] ||= { messages: [] }
    "Hello, #{user_name}! I'm your chatbot. What's on your mind?"
  end

  # Process a user message
  def process_message(user_name, message)
    @conversations[user_name][:messages] << { user: user_name, message: message }
    response = respond_to_message(message)
    @conversations[user_name][:messages] << { user: 'chatbot', message: response }
    response
  end

  # Save conversations to file
  def save_conversations
    File.open('conversations.yaml', 'w') { |f| f.write(@conversations.to_yaml) }
  end

  private

  # Simple response logic
  def respond_to_message(message)
    case message
    when /hello/i
      "Hello! How can I help you today?"
    when /help/i
      "I can assist you with any questions or topics you'd like to discuss."
    else
      "I didn't quite understand that. Can you rephrase or ask a question?"
    end
  end
end

# Command-line interface
if __FILE__ == $PROGRAM_NAME
  tracker = ChatbotTracker.new

  puts "Welcome to the Chatbot Tracker!"
  print "Enter your name: "
  user_name = gets.chomp

  loop do
    print "You: "
    message = gets.chomp
    break if message == 'exit'

    response = tracker.process_message(user_name, message)
    puts "Chatbot: #{response}"
  end

  tracker.save_conversations
end