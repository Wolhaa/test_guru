class Admin::BaseController < ApplicationController

  layout 'admin'

  before_action :authenticate_user!
  before_action :admin_require

  private

  def admin_require
    redirect_to root_path, alert: t('admin.restriction') unless current_user.admin?
  end
end
