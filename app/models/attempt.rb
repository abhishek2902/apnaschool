class Attempt < ApplicationRecord
  belongs_to :test
  belongs_to :user
  has_many :responses, dependent: :destroy
end
