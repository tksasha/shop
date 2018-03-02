class CategoryDecorator < Draper::Decorator
  delegate_all

  def as_json *args
    { id: id, slug: slug, name: name, image: image_url }
  end

  def image_url
    h.image_url image.url :'500x500'
  end
end
