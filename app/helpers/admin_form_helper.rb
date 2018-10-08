module AdminFormHelper

	def admin_validation_wrapper(valid, klass)
		klass ||= ""
		klass += " is-invalid" unless valid
		klass
	end

 	def admin_validation_message(attribute, object)
 		if object.errors.messages[attribute].present?
			content_tag(:span, class: "invalid-feedback d-block") {
    		object.errors.messages[attribute].reduce('') { |c, error| c << content_tag(:div, "#{attribute.to_s} #{error}") }.html_safe
			}
		end
	end

	def admin_text_field(attribute, object, options={})
		model_name = object.class.to_s.downcase
		class_name = admin_validation_wrapper(object.errors.messages[attribute].empty?, options[:klass])

    label_tag(attribute.to_s.capitalize) +
    text_field_tag("#{model_name}[#{attribute}]", object[attribute], class: class_name) +
    admin_validation_message(attribute, object)
  end

  def admin_text_area_field(attribute, object, options={})
  	model_name = object.class.to_s.downcase
		class_name = admin_validation_wrapper(object.errors.messages[attribute].empty?, options[:klass])

    label_tag(attribute.to_s.capitalize) +
    text_area_tag("#{model_name}[#{attribute}]", object[attribute], class: class_name) +
    admin_validation_message(attribute, object)
  end

  def admin_datetime_field(attribute, object, options={})
  	model_name = object.class.to_s.downcase
  	class_name = admin_validation_wrapper(object.errors.messages[attribute].empty?, options[:klass])

    label_tag(attribute.to_s.capitalize) +
    date_field_tag("#{model_name}[#{attribute}]", object[attribute].try(:to_date), class: class_name) +
    admin_validation_message(attribute, object)
  end

end