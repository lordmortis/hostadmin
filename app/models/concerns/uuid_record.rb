module UUIDRecord
  extend ActiveSupport::Concern

  included do

    before_create :generate_id
  end

  def uuid
    @uuid ||= UUIDTools::UUID.parse(self.id)
  end

  def generate_id
    self.id = SecureRandom.uuid
  end
end
