class Pet < ActiveRecord::Base
  has_many :owner_pets
  has_many :owners, through: :owner_pets
end
