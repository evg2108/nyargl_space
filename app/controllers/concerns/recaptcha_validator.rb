module RecaptchaValidator
  extend ActiveSupport::Concern

  private

  def validate_recaptcha
    unless verify_recaptcha
      set_error_message :authentication, :bad_recaptcha
      redirect_to :back
    end
  end
end