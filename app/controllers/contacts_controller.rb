class ContactsController < ActionController::Base

  def create
    @contact = Contact.new(contact_params)
    if @contact.save!
      head :ok
    else
      render json: {}, status: :unprocessable_entity
    end
  end

  private

  def contact_params
    params.require(:contact).permit(
      :fullname,
      :message,
      :email
    )
  end

end
