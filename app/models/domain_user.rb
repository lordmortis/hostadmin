class DomainUser < ApplicationRecord
  self.primary_keys = :domain_id, :user_id

  belongs_to :user
  belongs_to :domain
end
