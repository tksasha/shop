Rails.application.configure do
  config.action_mailer.default_url_options = { host: 'localhost:3000' }

  config.action_mailer.smtp_settings = {
    address: 'email-smtp.us-east-1.amazonaws.com',
    port: 587,
    user_name: 'AKIAJH7LPKFQK6LWCIWA',
    password: 'AiASWbWI/wl1OzgtU8hrwzLd5LaMORHC65S5xvBx9uDX',
    authentication: :login,
    enable_starttls_auto: true
  }
end
