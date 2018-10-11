class AdminFormBuilder < ActionView::Helpers::FormBuilder

	def admin_bs_text(method, tag_value, options = {})
		method = handle_association_method(method)
  	@template.label_tag(method) + 
    @template.text_field(
      @object_name, method, objectify_options(bootstrapize_input(method, options))
    ) + 
    validation_message(method)
  end

  def admin_bs_textarea(method, tag_value, options = {})
  	@template.label_tag(method) + 
    @template.text_area(
      @object_name, method, objectify_options(bootstrapize_input(method, options))
    ) + 
    validation_message(method)
  end

  def admin_bs_datetime(method, tag_value, options = {})
  	@template.label_tag(method) + 
    @template.datetime_field(
      @object_name, method, objectify_options(bootstrapize_input(method, options))
    ) + 
    validation_message(method)
  end

  def admin_bs_select(method, collection, value_method, text_method, options = {}, html_options = {})
  	cleansed_method = handle_association_method(method)
  	html_options 		= bootstrapize_input(cleansed_method, html_options)
  	html_options[:class] += "custom-select chosen-select"

  	@template.label_tag(method) + 
    @template.collection_select(
      @object_name, method, collection, value_method, text_method, objectify_options(options), objectify_options(html_options)
    ) + 
    validation_message(cleansed_method)
  end

  def admin_bs_checkbox(method, checked, options = {})
  	options[:class] ||= ''
  	options[:class] += ' form-check-input'

  	@template.content_tag(:div, class: "form-check") do 
  		@template.check_box_tag(method, true, checked, options) +
  		@template.label_tag(method, nil, class: "form-check-label")
  	end
  end

  def admin_bs_file(method, options = {})
  	options = bootstrapize_input(method, options)

  	@template.label_tag(method, nil, class: "d-block") + 
		@template.file_field(method, nil, options) 
  end



  private

  def bootstrapize_input(method, options)
  	options[:class] ||= ""
  	options[:class] += " form-control"
  	options[:class] += " is-invalid" if object.errors.messages[method].present?
  	options
  end

  def validation_message(method)
  	if object.errors.messages[method].present?
			@template.content_tag(:span, class: "invalid-feedback d-block") {
    		object.errors.messages[method].reduce('') { |c, error| c << @template.content_tag(:div, "#{method.to_s} #{error}") }.html_safe
			}
		end
  end

  def handle_association_method(method)
  	blacklisted_substring = '_id'
  	if method.to_s.last(3) == blacklisted_substring
  		method.to_s.gsub(blacklisted_substring, '').to_sym
  	else
  		method
  	end
  end
end