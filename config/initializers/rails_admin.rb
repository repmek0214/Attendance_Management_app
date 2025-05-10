RailsAdmin.config do |config|

  config.authenticate_with do
   warden.authenticate! scope: :user
  end

  config.current_user_method(&:current_user)

  config.asset_source = :sprockets

  config.authorize_with :cancancan

  config.main_app_name = ["勤怠管理システム", "管理画面"]
end
