# The majority of The Supplejack Website code is Crown copyright (C) 2014, New Zealand Government,
# and is licensed under the GNU General Public License, version 3. Some components are 
# third party components that are licensed under the MIT license or other terms. 
# See https://github.com/DigitalNZ/supplejack_website for details. 
# 
# Supplejack was created by DigitalNZ at the National Library of NZ and the Department of Internal Affairs. 
# http://digitalnz.org/supplejack

class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :search

  def search(special_params=nil)
    @search ||= Search.new(special_params || params[:search] || params)
  end

  def current_sj_user(user_id=nil)
    @current_sj_user ||= begin
      user = user_id ? User.find(user_id) : current_user
      Supplejack::User.new({authentication_token: user.api_key}) if user
    end
  end
end
