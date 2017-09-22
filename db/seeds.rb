raise 'Are you crazy?!!!' unless Rails.env.development?

16.times.map do
  Category.create! name: Faker::Commerce.product_name, image: Faker::LoremPixel.image('500x500')
end unless Category.first

__END__
categories_count = Category.count

5000.times.map do
  offset = rand categories_count - 1

  category = Category.offset(offset).first

  Product.create name: Faker::Commerce.product_name, price: Faker::Commerce.price, categories: [category]
end unless Product.first

Version.create unless Version.first
