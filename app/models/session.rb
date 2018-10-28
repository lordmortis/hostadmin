class Session < ApplicationRecord
  include UUIDRecord

  include ActsAsApiAuthable::Models::Token
end
