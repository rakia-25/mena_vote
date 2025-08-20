class UsersController < GenericsController
  private

  def user_params
    params.require(:user).permit(
      :email,
      :profile,
      :password,
      :password_confirmation
    )
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
end
