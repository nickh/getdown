OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV["FB_GETDOWN_APP_ID"], ENV["FB_GETDOWN_APP_SECRET"]
end
