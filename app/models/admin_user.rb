class AdminUser < ApplicationRecord
  # Devise handles admin login: hashed passwords, "remember me", and email/password checks.
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  # Columns the admin filter sidebar is allowed to search (Ransack safety list).
  # encrypted_password and reset tokens are left OUT on purpose so they can never be searched.
  def self.ransackable_attributes(auth_object = nil)
    [ "id", "email", "created_at", "updated_at" ]
  end

  # Admin users aren't linked to other tables, so nothing to search through.
  def self.ransackable_associations(auth_object = nil)
    []
  end
end