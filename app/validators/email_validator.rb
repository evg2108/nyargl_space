#http://guides.rubyonrails.org/active_record_validations.html#custom-validators

class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      record.errors[attribute] << (options[:message] || I18n.t('error_messages.email.bad_format') || 'is not an email')
    end
  end
end