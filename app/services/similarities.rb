class Similarities
  def initialize product, order
    @product = product

    @order = order
  end

  def update!
    @product.update! similarities: merged_similarities
  end

  private
  def purchases
    @order.purchases.inject([]) do |results, purchase|
      results.push product_id: purchase.product_id, amount: purchase.amount
    end
  end

  def source_similarities
    return [] unless @product.similarities.respond_to? :map

    @product.similarities.map &:symbolize_keys
  end

  def source_similarities_hash
    source_similarities.inject({}) do |results, similarities|
      results[similarities[:product_id]] = similarities[:amount]

      results
    end
  end

  def merged_similarities_hash
    results = source_similarities_hash

    purchases.each do |purchase|
      if results.key? purchase[:product_id]
        results[purchase[:product_id]] += purchase[:amount]
      else
        results[purchase[:product_id]] = purchase[:amount]
      end
    end

    results
  end

  def merged_similarities
    merged_similarities_hash.inject([]) do |results, (product_id, amount)|
      results.push product_id: product_id, amount: amount
    end
  end

  class << self
    def update! *args
      new(*args).update!
    end
  end
end
