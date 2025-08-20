class InscriptionDecorator < ApplicationDecorator
  delegate_all

  def image_url
    object.image.attached? ? Rails.application.routes.url_helpers.rails_blob_path(object.image, only_path: true) : ''
  end

  def name
    "#{object.first_name} - #{object.last_name}"
  end

  def displayed_status
    I18n.t("enum.status.#{ object.status }") unless object.status.blank?
  end

  def displayed_age
    I18n.t("enum.age.#{ object.age }") unless object.age.blank?
  end

  def displayed_studying_level
    I18n.t("enum.studying_level.#{ object.studying_level }") unless object.studying_level.blank?
  end

  def displayed_height
    "1m/#{object.height}" unless object.age.blank?
  end

  def region_name
    object.region.name
  end

  def validation_status
    status = I18n.t("enum.status.#{ object.status }") unless object.status.blank?
      h.content_tag(:span, "#{status}", class: 'tag is-success is-light has-text-weight-semibold')
  end
end
