class Like < ApplicationRecord
  belongs_to :client, class_name: "User", foreign_key: "client_id"
  belongs_to :architect

  validates :client_id, uniqueness: { scope: :architect_id }

  validate :user_is_client
  private

  def user_is_client
    errors.add(:client, "doit avoir le role de client") unless client&.client?
  end
end
