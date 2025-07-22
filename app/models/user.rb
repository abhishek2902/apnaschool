class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  enum :role, { student: 0, teacher: 1, admin: 2 }, prefix: true, suffix: true

  after_initialize :set_default_role, if: :new_record?

  validates :name, presence: true  # Ensure name is required

  def set_default_role
    self.role ||= :student  # Default role
  end

  # Helper methods for checking roles
  def admin?
    role == "admin"
  end

  def teacher?
    role == "teacher" || admin?
  end

  has_many :tests
  has_many :responses
  has_many :attempts
  has_many :doubts
end
