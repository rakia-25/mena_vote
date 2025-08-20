class EmailValidator < ActiveModel::EachValidator
  VALID_CHARS = /^\d{8}$/

  def validate_each(record, attribute, value)
    unless value =~ VALID_CHARS
      record.errors[attribute] << (options[:message] || "n'est pas valide. Ex: john...@gmail.com")
    end
  end
end
