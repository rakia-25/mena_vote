class ChechoutPagesController < ApplicationController
  layout 'checkout_page'

  def index
    @setting = Setting.first
    redirect_to root_path and return if @setting.show_candidate_section? == false
    redirect_to root_path and return if @setting.vote? == false
    @payment = Payment.find(params[:payment_id])

    @amount = @payment.amount
    @transaction_id = @payment.order_id
    @environement = "live"
    @public_key = "pk_2c2ee44ffc334c98a811e8f08851462b"
    @redirect_url = "https://www.menavote.com/"
  end
end
