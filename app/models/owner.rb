class Owner < ActiveRecord::Base
  has_many :owner_pets
  has_many :pets, through: :owner_pets
end
