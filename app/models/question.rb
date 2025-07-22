class Question < ApplicationRecord
  belongs_to :test
  has_many :responses, dependent: :destroy
end
