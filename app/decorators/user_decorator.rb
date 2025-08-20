class UserDecorator < ApplicationDecorator
  delegate_all

  def code
    object.id
  end

  def displayed_profile
    I18n.t("enum.profile.#{ object.profile }") unless object.profile.blank?
  end

end
