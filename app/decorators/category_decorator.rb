class CategoryDecorator < Draper::Decorator
  delegate_all

  def as_json *args
    { id: id, name: name, image: image_url }
  end

  def image_url
    h.image_url image.url
  end
end
