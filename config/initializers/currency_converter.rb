CurrencyConverter::Options.currencies = [:usd, :uah, :eur]

CurrencyConverter::Options.default_currency = :usd

CurrencyConverter::Options.currency_options[:usd] = { precision: 2, format: '$ %<amount>s' }

CurrencyConverter::Options.currency_options[:eur] = { precision: 2, format: '€ %<amount>s' }
