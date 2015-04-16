class RegistrationMailer < ApplicationMailer
  attr_accessor :password, :temporary_token, :email
  helper_method :password, :temporary_token, :email

  def send_email_confirmation(email, password, temporary_token)
    self.email = email
    self.password = password
    self.temporary_token = temporary_token
    mail(to: email, subject: I18n.t('mailers.registration.subject'))
  end
end
