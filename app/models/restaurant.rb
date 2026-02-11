class Restaurant < ApplicationRecord
  has_many :dishes, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :ratings, dependent: :destroy
  belongs_to :owner, class_name: "User", foreign_key: "owner_id"
  validates :name, :description,  presence: true
  validates :name, length: { minimum: 3, maximum: 20 }
  validates :rating, numericality: {
    greater_than_or_equal_to: 1,
    less_than_or_equal_to: 5
  }
end
