class WidgetsController < ApplicationController
  skip_before_action :authenticate!, only: :index

  skip_before_action :authorize_collection, only: :index

  layout 'widgets'

  helper_method :categories

  private
  def categories
    [
      ['widgets/alcohol.jpg', 'Alcohol'],
      ['widgets/sweets_and_desserts.jpg', 'Sweets and Desserts'],
      ['widgets/beer.jpg', 'Beer'],
      ['widgets/red_dry_wine.jpg', 'Red Dry Wine'],
      ['widgets/stationery.jpg', 'Stationery'],
      ['widgets/sausages_wieners_and_frankfurters.jpg', 'Sausages and Wieners'],
      ['widgets/donuts.jpg', 'Donuts'],
      ['widgets/chickens.jpg', 'Chickens'],
    ]
  end
end
