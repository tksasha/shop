class ApplicationSearcher
  attr_reader :results

  def initialize relation, params = nil
    @results = relation

    @params = params
  end

  def search
    return @results unless @params.respond_to? :each

    @params.each do |attribute, value|
      method_name = :"search_by_#{ attribute }"

      @results = send method_name, value if respond_to?(method_name, true)
    end

    @results
  end

  class << self
    def search *args
      new(*args).search
    end
  end
end
