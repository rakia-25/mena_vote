class ChatBotsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def webhook
    BotService.new(params).reply
    head :ok
  end
end
