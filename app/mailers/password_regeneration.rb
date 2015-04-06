class PasswordRegeneration < ApplicationMailer
  default from: 'notifications@nyargl_space.org'

  attr_accessor :password
  helper_method :password

  def send_new_password(email, new_password)
    self.password = new_password
    mail(to: email, subject: I18n.t('mailers.password_regeneration.subject'))
  end
end
