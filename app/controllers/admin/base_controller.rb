class Admin::BaseController < ApplicationController
    before_action :authenticate_user!
    before_action :require_admin
  
    private
  
    def require_admin
      redirect_to root_path, alert: "管理者専用ページです" unless current_user.admin?
    end
  end