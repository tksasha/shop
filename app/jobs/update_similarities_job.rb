class UpdateSimilaritiesJob < ApplicationJob
  queue_as :default

  def perform order
    order.products.map { |product| Similarities.update! product, order }
  end
end
