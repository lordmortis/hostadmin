module Archivable
  extend ActiveSupport::Concern

  included do
  end

  def archive!
    self.update(archived: true)
  end

  def archive
    self.archived = true
  end

  def unarchive!
    self.update(archived: false)
  end

  def unarchive
    self.archived = false
  end
end
