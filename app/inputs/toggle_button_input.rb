# Usage:
#
# for using this input set up "as" param in :toggle_button
# for correct usage you must use bootstrap tooltips
# also you need require inputs/toggle_button_input.js file if you want to use ajax
#
# = simple_form_for current_author do |f|
#   = f.input :enabled, as: :toggle_button, tooltip_placement: 'right'
class ToggleButtonInput < SimpleForm::Inputs::Base

  disable :label

  def input(wrapper_options)
    cond_result = object.send("#{attribute_name}?")

    %i(value title).each do |attr|
      input_html_options[attr] = I18n.t("simple_form.toggle_buttons.#{object_name}.#{attribute_name}.#{attr}.#{cond_result}", default: "Now it's #{cond_result}. Click this button to switch #{cond_result ? 'off' : 'on'}")
      input_html_options["data-false-#{attr}"] = I18n.t("simple_form.toggle_buttons.#{object_name}.#{attribute_name}.#{attr}.false", default: "#{attr}: Now it's false. Click this button to switch on")
      input_html_options["data-true-#{attr}"] = I18n.t("simple_form.toggle_buttons.#{object_name}.#{attribute_name}.#{attr}.true", default: "#{attr}: Now it's true. Click this button to switch off")
    end
    input_html_options['data-state'] = cond_result

    input_html_options['data-toggle'] = 'tooltip'
    input_html_options['data-placement'] = options[:tooltip_placement] || 'auto'

    out = ActiveSupport::SafeBuffer.new
    out << @builder.hidden_field(attribute_name, value: !cond_result, class: 'toggle_button_value_field')
    out << @builder.button(:submit, input_html_options)
  end
end