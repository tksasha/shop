raise 'Are you crazy?!!!' unless Rails.env.development?

100.times.map do
  Category.create name: Faker::Commerce.department
end unless Category.first

categories_count = Category.count

5000.times.map do
  offset = rand categories_count - 1

  category = Category.offset(offset).first

  Product.create name: Faker::Commerce.product_name, price: Faker::Commerce.price, categories: [category]
end unless Product.first

Version.create unless Version.first
