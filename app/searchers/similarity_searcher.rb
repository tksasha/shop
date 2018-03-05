class SimilaritySearcher
  attr_reader :product_id

  def initialize params
    @product_id = params[:product_id]
  end

  def search
    Product.
      from('products AS t1, jsonb_to_recordset(t1.similarities) AS similarities(product_id integer, amount integer)').
      joins('INNER JOIN products ON products.id=similarities.product_id').
      where('t1.id = ? ', product_id).
      order('similarities.amount DESC')
  end

  class << self
    def search *args
      new(*args).search
    end
  end
end
