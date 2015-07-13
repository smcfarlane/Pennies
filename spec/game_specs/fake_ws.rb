require 'json'

class FakeWS
  attr_reader :message_sent, :data
  def initialize data
    @message_sent = false
    @data = JSON.dump data
  end

  def send message
    p 'message sent to client:'
    p message
    @message_sent = true
    message
  end

  def on event
    yield self if event == :message
  end
end
