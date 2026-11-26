class Customer < ApplicationRecord
  belongs_to :province
  has_many :orders

  validates :name, presence: true, length: { maximum: 100 }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :address, presence: true, length: { maximum: 150 }
  validates :city, presence: true, length: { maximum: 80 }
  validates :postal_code, presence: true,
                          format: { with: /\A[A-Za-z]\d[A-Za-z][ -]?\d[A-Za-z]\d\z/,
                                    message: "must be a valid Canadian postal code" }

  def self.ransackable_attributes(auth_object = nil)
    [ "id", "name", "email", "address", "city", "postal_code", "province_id", "created_at", "updated_at" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "province", "orders" ]
  end
end