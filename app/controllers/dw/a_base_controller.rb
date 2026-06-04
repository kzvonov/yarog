module Dw
  class ABaseController < ApplicationController
    before_action :character
    after_action :write_dw_content_src_cookie

    def character
      @character ||= Current.account.characters.find(params[:character_param].to_i)
      raise "invalid system for char #{@character.id}" if !@character.is_a?(DungeonWorld::Character)
      @character
    end

    def write_dw_content_src_cookie
      cookies[:dw_content_src] = request.path
    end
  end
end
