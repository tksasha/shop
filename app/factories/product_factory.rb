class ProductFactory
  def initialize params={}
    @categories = params.delete(:categories).reject { |c| c.blank? }

    @params = params
  end

  def build
    product = Product.new @params.merge categories: Category.find(@categories)
  end

  class << self
    def build *args
      new(*args).build
    end
  end
end
