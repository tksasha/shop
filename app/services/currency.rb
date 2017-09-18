class Currency < String
  def initialize value, currency
    @value = value

    @currency = currency.to_sym

    super to_s
  end

  def to_d
    @value
  end

  def to_s
    case @currency
    when :usd
      "$#{ @value }"
    when :eur
      "€#{ @value }"
    else
      "#{ @value } #{ @currency.to_s.upcase }"
    end
  end
end
