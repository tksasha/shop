class Converter
  API_URL = "http://free.currencyconverterapi.com/api/v3/convert?q=%s&compact=ultra"

  attr_reader :from, :to

  def initialize params
    @from = params[:from]

    @to = params[:to]
  end

  def convert value
    result = (value * rate).round 2

    Currency.new result, to
  end

  private
  def redis
    @redis ||= Redis.new
  end

  def pair
    @pair ||= "#{ @from.to_s.upcase }_#{ @to.to_s.upcase }"
  end

  def rate
    return 1 if @from == @to

    result = redis_rate

    self.redis_rate = result = api_rate unless result

    result
  end

  def redis_rate
    result = redis.get "currency:#{ pair }"

    result.to_d if result
  end

  def redis_rate= value
    redis.setex "currency:#{ pair }", 1.hour, value
  end

  def api_rate
    result = nil

    open(API_URL % pair) { |response| result = JSON.parse(response.read)[pair] }

    result.to_d if result
  end
end
