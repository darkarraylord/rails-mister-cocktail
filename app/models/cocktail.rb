class Cocktail < ApplicationRecord
  has_many :doses, dependent: :destroy
  has_many :ingredients, through: :doses
  has_many :votes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_attachments :photos, maximum: 2

  validates :name, uniqueness: true, presence: true
end
