class Reply < ApplicationRecord
  belongs_to :grievance

  before_create :set_default_date

  private

  def set_default_date
    self.date ||= Time.current  # Set date only if it's nil
  end
end