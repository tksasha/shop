Currency::Options.currencies = [:usd, :uah, :eur]

Currency::Options.default_currency = :usd

Currency::Options.currency_options[:usd] = { precision: 2, format: '$ %<amount>s' }

Currency::Options.currency_options[:eur] = { precision: 2, format: '€ %<amount>s' }
