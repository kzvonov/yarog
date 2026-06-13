class ApplicationController < ActionController::Base
  include Authentication
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # had - heroes & adeventures
  layout "had"
  default_form_builder HadFormBuilder
end
