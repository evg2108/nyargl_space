module FlashMessenger
  extend ActiveSupport::Concern

  MESSAGE_TYPES = %i(alert success error warning information confirmation)

  included do
    MESSAGE_TYPES.each do |message_type|
      define_method "set_#{message_type}_message" do |*args|
        flash[message_type] = I18n.t("messages.#{message_type}.#{args.join('.')}")
      end
    end
  end
end