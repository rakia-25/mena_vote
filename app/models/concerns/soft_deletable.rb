
module SoftDeletable
  extend ActiveSupport::Concern
  included do
    scope :not_deleted, -> { where(deleted_at: nil) }
    scope :deleted, -> { where.not(deleted_at: nil) }

    attr_accessor :set_deleted

    before_save { check_if_deleted }

    def delete!
      return false if deleted?
      touch(:deleted_at)
    end

    def undelete!
      return false unless deleted?
      !!update(deleted_at: nil)
    end

    def deleted?
      deleted_at.present?
    end

    private

    def check_if_deleted
      case set_deleted
      when TrueClass
        self.deleted_at = Time.now
      when FalseClass
        self.deleted_at = nil
      end
    end

  end
end