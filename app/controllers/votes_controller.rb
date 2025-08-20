class VotesController < ApplicationController
  layout 'public'
  skip_before_action :verify_authenticity_token, only: :callback_sms

  def callback_sms
    valid_chars = /^\d{8}$/
    phone = params[:body][:phone][4..]
    if (phone =~ valid_chars)
      number = params[:body][:content]
      @candidate = Candidate.find_by(number: number, year_id: 2)
      @voter = Voter.create!(phone: phone, candidate_id: @candidate.id, voted_at: Time.now)
      @candidate.update!(votes: @candidate.votes + 1)
      VoteWorker.perform_async(@candidate.id)
      SmsService.new("227#{phone}", "Votre vote pour la candidate Numero.#{number} a ete pris en compte. Vous pouvez aussi voter sur https://www.missniger.show/").launch
    else
      render json: {errors: 'Phone incorrect'}, status: :unprocessable_entity
    end
  end
end
