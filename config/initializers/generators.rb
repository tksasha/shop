Rails.application.configure do
  config.generators do |g|
    g.helper false
    g.controller assets: false, decorator: false
  end
end
