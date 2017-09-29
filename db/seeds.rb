raise 'Are you crazy?!!!' unless Rails.env.development?

16.times.map do
  filename = 'tmp/image.jpeg'

  file = File.open filename, 'wb+'

  file.write open(Faker::LoremPixel.image('500x500')).read

  file.close

  Category.create! name: Faker::Commerce.product_name, image: File.open(filename)

  File.unlink filename
end unless Category.first

Version.create unless Version.first

Category.all.map do |category|
  filename = 'tmp/image.jpeg'

  file = File.open filename, 'wb+'

  file.write open(Faker::LoremPixel.image('500x500')).read

  file.close

  Product.create! \
    name: Faker::Commerce.product_name,
    price: Faker::Commerce.price,
    categories: [category],
    image: File.open(filename)
end unless Product.first
