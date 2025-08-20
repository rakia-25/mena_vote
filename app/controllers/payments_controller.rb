class PaymentsController < ApplicationController
  layout 'public'
  skip_before_action :verify_authenticity_token, only: :webhook

  def create
    @setting = Setting.first
    redirect_to root_path and return if @setting.show_candidate_section? == false
    redirect_to root_path and return if @setting.vote? == false
    
    @year = Year.find_by(current_year: true)
    @candidate = Candidate.find_by(vote_code: params[:payment][:vote_code], year_id: @year.id)
    amount = params[:payment][:vote_number].to_i

    if amount < 0
      redirect_to root_path, alert: "Le montant ne peut pas être négatif"
    else
      @payment = Payment.new(payment_params.merge(
        status: 0,
        order_id: "tarmamun-voter-#{params[:payment][:vote_code]}-#{Time.now.to_i}",
        amount: amount * 100
      ))
  
      respond_to do |format|
        if @payment.save
          @voter = Voter.create(candidate_id: @candidate.id, payment_id: @payment.id)
          format.json { render json: { checkout: chechout_pages_path(payment_id: @payment.id) } }
        else
          format.json do
            render json: { errors: @payment.errors.full_massages }, status: :unprocessable_entity
          end
        end
      end
    end
  end
  
  def webhook
    # return if request.headers['secret-hash'] != 'sdfsewrfwer90wr809w8r7wer'

    @payment = Payment.find_by('order_id = ?', params['data']['external_reference'])
    @status = params['data']['status']

    if (@payment.order_id.split('-')[1] == 'voter')
      @voter = Voter.find_by(payment_id: @payment.id)
      return if @voter.voted_at.present?
      return if @payment.amount != params['data']['amount']

      if @status == 'succeeded'
        @candidate = Candidate.find(@voter.candidate_id)
        @candidate.update(votes: @candidate.votes + (@payment.amount / 100))
        @voter.update(voted_at: Time.now, phone: params['data']['msisdn'])
        update_payment_status_success()
      elsif @status == 'failed'
        update_payment_status_failed()
        @voter.update(voted_at: Time.now, phone: params['data']['msisdn'])
      end
    else
      if @status == 'succeeded'
        update_payment_status_success()
      elsif @status == 'failed'
        update_payment_status_failed()
      end
    end

    head :ok
  end

  private

  def payment_params
    params.require(:payment).permit(
      :vote_number,
      :vote_code
    )
  end

  def update_payment_status_success
    @payment.update(status: 'success', validated_at: Time.now, trid: params['data']['reference'], txnid: @payment.order_id, ipay_reference: params['data']['reference'], payment_phone: params['data']['msisdn'])
  end

  def update_payment_status_failed
    @payment.update(status: 'failed', validated_at: Time.now, ipay_reference: params['data']['reference'], payment_phone: params['data']['msisdn'])
  end
end
