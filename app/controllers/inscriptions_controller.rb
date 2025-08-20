class InscriptionsController < GenericsController
  layout 'inscription', only: [:new, :create]
  skip_before_action :authenticate_user!, only:[:new, :create]

  def new
    @payment_uid = SecureRandom.hex(3)
    @inscription = Inscription.new(payment_uid: @payment_uid)
  end

  def create
    @inscription = Inscription.new(inscription_params)
    if @inscription.valid?
      ActiveRecord::Base.transaction do
        if @inscription.inscription_fee
          validate_inscription_with_payment()
          @payment = @payment.reload
        else
          validate_inscription_without_payment()
        end
      end
      @payment = @payment.nil? ? {} : @payment.reload 
      render json: {payment: @payment, checkout: chechout_pages_path(payment_id: @payment.id)}
    else
      render json: { errors: @inscription.errors.messages}, status: :unprocessable_entity
    end
  end

  def destroy
    @inscription = Inscription.find(params[:id])
    @inscription.delete!
    redirect_to inscriptions_url, notice: 'Action éffectuée avec succès.'
  end

 private

  def inscription_params
    params.require(:inscription).permit(
      :first_name,
      :last_name,
      :phone_whatsapps,
      :weigth,
      :height,
      :profession,
      :studying_level,
      :age,
      :email,
      :address,
      :photo,
      :status,
      :inscription_fee,
      :payment_uid,
      :payment_phone,
      :facebook_url,
      :linkedin_url,
      :instagram_url,
      :tiktok_url,
      :region_id,
      :approved
    ).merge(year_id: Year.find_by(current_year: true).id)
  end

  def filter_params
    if params[:filter].present?
      params.require(:filter)
      .permit(
        :created_from,
        :created_to
      )
    else
      {}
    end
  end

  def validate_inscription_with_payment
    @inscription.save!
    @payment = Payment.create!(
      data: params[:inscription],
      payment_phone: @inscription.payment_phone,
      payment_uid: @inscription.payment_uid,
      status: 'initiated',
      order_id: "Miss-#{@inscription.payment_uid}-#{Time.now().to_i}",
      # amount: @inscription.inscription_fee? ? 21000 : 1000
      amount: 20000
    )
  end

  def validate_inscription_without_payment
    @inscription.save!
    @payment = nil
  end
end
