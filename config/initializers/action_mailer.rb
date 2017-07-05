Rails.application.configure do
  config.action_mailer.default_url_options = { host: ENV['HOST'] }

  config.action_mailer.smtp_settings = {
    address: 'email-smtp.eu-west-1.amazonaws.com',
    port: 587,
    user_name: ENV['SES_SMTP_USERNAME'],
    password: ENV['SES_SMTP_PASSWORD'],
    authentication: :login,
    enable_starttls_auto: true
  }
end
