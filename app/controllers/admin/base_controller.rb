class Admin::BaseController < ApplicationController
  
  layout 'admin'

  before_action :authenticate_user!
  before_action :admin_require

  private

  def admin_require
    redirect_to root_path, alert: 'You are not authorized ti view this page!' unless current_user.is_a?(Admin)
  end
end
