class Home
  def categories
    @categories ||= Category.order :name
  end
end
