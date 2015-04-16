class PasswordRegenerationMailer < ApplicationMailer
  attr_accessor :password, :temporary_token, :email
  helper_method :password, :temporary_token, :email

  def send_new_password(email, new_password, temporary_token)
    self.email = email
    self.password = new_password
    self.temporary_token = temporary_token
    mail(to: email, subject: I18n.t('mailers.password_regeneration.subject'))
  end
end
