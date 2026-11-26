class Order < ApplicationRecord
  STATUSES = %w[new paid shipped].freeze

  belongs_to :customer
  has_many :order_items, dependent: :destroy

  validates :status, presence: true, inclusion: { in: STATUSES }
  validates :gst_rate, :pst_rate, :hst_rate, presence: true,
                                             numericality: { greater_than_or_equal_to: 0 }
  validates :subtotal, :gst_amount, :pst_amount, :hst_amount, :total,
            presence: true, numericality: { greater_than_or_equal_to: 0 }

  def self.ransackable_attributes(auth_object = nil)
    [ "id", "customer_id", "status", "subtotal", "gst_rate", "pst_rate", "hst_rate",
      "gst_amount", "pst_amount", "hst_amount", "total", "created_at", "updated_at" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "customer", "order_items" ]
  end
end