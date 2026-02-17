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
  validates :street, :city, :state, presence: true
  geocoded_by :address do |object, results|
    if results.present?
      object.latitude = results.first.latitude
      object.longitude = results.first.longitude
    else
      object.latitude = nil
      object.longitude = nil
    end
  end

  before_validation :geocode, if: :address_changed?
  validate :found_address_presence

  def address
    [ street, city, state ].compact.join(", ")
  end

  def address_changed?
    street_changed? || city_changed? || state_changed?
  end

  private

  def found_address_presence
    if latitude.blank? || longitude.blank?
      errors.add(:address, "We couldn't find the exact location for the provided address")
    end
  end
end
