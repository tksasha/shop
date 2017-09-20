class Currency < String
  ALLOWED = %i(usd eur uah)

  attr_reader :name, :value

  def initialize name: nil, value: nil
    @name = name.to_sym

    @value = value.round 2

    super to_s
  end

  def to_d
    value
  end

  def to_s
    case name
    when :usd
      "$#{ '%.2f' % value }"
    when :eur
      "€#{ '%.2f' % value }"
    else
      "#{ value } #{ name.to_s.upcase }"
    end
  end
end
