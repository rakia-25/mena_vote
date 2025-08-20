module ErrorsHelper
  def form_field_error_helper(resource, field)
    resource.errors[field].present? ? raw("<div class='help is-danger'>#{resource.errors[field]&.to_sentence}</div>") : ''
  end

  def form_field_error_class(resource, field)
    resource.errors[field].present? ? 'is-danger' : ''
  end
end
