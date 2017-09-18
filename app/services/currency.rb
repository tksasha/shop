class Currency < String
  def initialize value, currency
    @value = value

    @currency = currency

    super to_s
  end

  def to_d
    @value
  end

  def to_s
    case @currency
    when :usd, 'usd'
      "$#{ @value }"
    when :eur, 'eur'
      "€#{ @value }"
    else
      "#{ @value } #{ @currency.to_s.upcase }"
    end
  end
end
