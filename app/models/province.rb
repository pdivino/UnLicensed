class Province < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: { maximum: 50 }
  validates :code, presence: true, uniqueness: true, length: { is: 2 }
  validates :gst, :pst, :hst, presence: true,
                              numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 1 }

  # Total tax rate for this province, as a decimal (0.12 means 12%).
  def total_tax_rate
    gst + pst + hst
  end

  def self.ransackable_attributes(auth_object = nil)
    [ "id", "name", "code", "gst", "pst", "hst", "created_at", "updated_at" ]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end