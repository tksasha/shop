raise 'Are you crazy?!!!' unless Rails.env.development?

exit 0

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
  10.times do
    filename = 'tmp/image.jpeg'

    file = File.open filename, 'wb+'

    file.write open(Faker::LoremPixel.image('500x500')).read

    file.close

    begin
      Product.create! \
        name: Faker::Commerce.product_name,
        price: Faker::Commerce.price,
        categories: [category],
        image: File.open(filename)
    rescue ActiveRecord::RecordInvalid
      retry
    end
  end
end unless Product.first
