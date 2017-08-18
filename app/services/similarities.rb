class Similarities
  def initialize product, order
    @product = product

    @order = order
  end

  def update!
    @product.update! similarities: similarities
  end

  private
  def product_similarities
    return [] unless @product.similarities.respond_to? :map

    @product.similarities.map &:symbolize_keys
  end

  def purchases_similarities
    @order.purchases.inject([]) do |results, purchase|
      if purchase.product_id == @product.id
        results
      else
        results.push product_id: purchase.product_id, amount: purchase.amount
      end
    end
  end

  def similarities_hash
    (product_similarities + purchases_similarities).inject(Hash.new 0) do |results, similarity|
      results[similarity[:product_id]] += similarity[:amount]

      results
    end
  end

  def similarities
    similarities_hash.inject([]) { |results, (product_id, amount)| results.push(product_id: product_id, amount: amount) }
  end

  class << self
    def update! *args
      new(*args).update!
    end
  end
end
