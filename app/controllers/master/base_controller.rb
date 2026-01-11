module Master
  class BaseController < ApplicationController
    layout "master"
    http_basic_authenticate_with name: ENV.fetch("DM_USERNAME", "dm"), password: ENV.fetch("DM_PASSWORD", "password")
  end
end
