class Restaurant < ApplicationRecord
  validates :title, presence: true

  default_scope { where(deleted_at: nil) }
  scope :available, -> { where(deleted_at: nil) }

  def self.deleted_at
    unscope(:where).where.not(deleted_at: nil)
  end

  def really_destroy!
    super.destroy
  end
  
  def destroy
    update(deleted_at: Time.now)
  end
end
