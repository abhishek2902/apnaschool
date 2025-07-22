class Grievance < ApplicationRecord
  has_many :replies, dependent: :destroy

  before_create :set_default_date

  private

  def set_default_date
    self.date ||= Time.current  # Set date only if it's nil
  end
end
