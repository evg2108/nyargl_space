module FlashMessenger
  extend ActiveSupport::Concern

  MESSAGE_TYPES = %i(alert success error warning information confirmation)

  included do
    MESSAGE_TYPES.each do |message_type|
      define_method "#{message_type}_message" do |*args|
        I18n.t("messages.#{message_type}.#{args.join('.')}")
      end

      define_method "set_#{message_type}_message" do |*args|
        flash[message_type] = send("#{message_type}_message", *args)
      end

      define_method "simple_#{message_type}_message" do |*args|
        args.flatten.join(";\n")
      end

      define_method "set_simple_#{message_type}_message" do |*args|
        flash[message_type] = send("simple_#{message_type}_message", *args)
      end
    end
  end
end