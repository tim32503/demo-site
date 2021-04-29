class FavoriteRestaurant < ApplicationRecord
  belongs_to :user
  belongs_to :restaurants
end
