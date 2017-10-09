class CurrencyConverter
  REMOTE_API = 'http://free.currencyconverterapi.com/api/v3/convert?compact=ultra'

  EXPIRATION = 1.hour

  def initialize from: nil, to: nil, sum: 0.0
    @from = from.presence || Currency::DEFAULT

    @to = to || Currency::DEFAULT

    @sum = sum
  end

  def cached_exchange_rate= rate
    $redis.setex "currencies_exchange_rate:#{ currencies }", EXPIRATION, rate
  end

  def convert
    Currency.new name: @to, value: @sum * exchange_rate
  end

  private
  def currencies
    "#{ @from.to_s.upcase }_#{ @to.to_s.upcase }"
  end

  def cached_exchange_rate
    $redis.get("currencies_exchange_rate:#{ currencies }")&.to_d
  end

  def remote_exchange_rate
    json = JSON.parse open("#{ REMOTE_API }&q=#{ currencies }").read

    (json[currencies] || 0).to_d
  end

  def exchange_rate
    return 1 if @from == @to

    unless cached_exchange_rate
      self.cached_exchange_rate = remote_exchange_rate
    end

    cached_exchange_rate
  end

  class << self
    def convert *args
      new(*args).convert
    end
  end
end
