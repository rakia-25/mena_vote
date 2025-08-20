class PhoneValidator < ActiveModel::EachValidator
  VALID_CHARS = /^\d{8}$/

  def validate_each(record, attribute, value)
    unless value =~ VALID_CHARS
      record.errors[attribute] << (options[:message] || "n'est pas valide. Ex: 90345678")
    end
  end
end
