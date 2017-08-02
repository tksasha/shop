class ApplicationSearcher
  def initialize params={}
    @params = params
  end

  def search
    initialize_results

    @params.each do |attribute, value|
      if value.present?
        method_name = :"search_by_#{ attribute }"

        send method_name, value if respond_to? method_name, true
      end
    end

    @results
  end

  private
  def initialize_results
    @results = resource_model.all
  end

  def resource_model
    @resource_model ||= self.class.name.gsub(/Searcher\z/, '').constantize
  end

  class << self
    def search params={}
      new(params).search
    end

    private
    def search_by_attributes *attributes
      attributes.each do |attribute|
        method_name = :"search_by_#{ attribute }"

        define_method method_name do |value|
          @results = @results.send method_name, value if @results.respond_to? method_name, true
        end

        private method_name
      end
    end
  end
end
