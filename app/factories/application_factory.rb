class ApplicationFactory
  def initialize params={}
    @params = params
  end

  def build
    resource_model.new params
  end

  private
  attr_reader :params

  def resource_model
    @resource_model ||= self.class.name.gsub(/Factory\z/, '').constantize
  end

  class << self
    def build *args
      new(*args).build
    end
  end
end
