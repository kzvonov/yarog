class HadFormBuilder < ActionView::Helpers::FormBuilder
  def group(method, label_text = nil, &block)
    @template.content_tag(:div, class: "form-group") do
      if method.nil? || method == "" || method == "-"
        @template.capture(&block)
      else
        label(method, label_text) + @template.capture(&block)
      end
    end
  end

  def label(method, text = nil, options = {}, &block)
    super(method, text, merge_class("form-label", options), &block)
  end

  def text_field(method, options = {})
    super(method, merge_class("form-input", options))
  end

  def select(method, choices = nil, options = {}, html_options = {})
    super(method, choices, options, merge_class("form-input", html_options))
  end

  def text_area(method, options = {})
    super(method, merge_class("form-input", options))
  end

  def submit(method, options = {})
    super(method, merge_class("btn-submit", options))
  end

  private

  def merge_class(base, options)
    options.merge(class: [ base, options[:class] ].compact.join(" "))
  end
end
