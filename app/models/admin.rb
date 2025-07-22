class Admin < ApplicationRecord
    validates :name, presence:true

    validates :email, uniqueness: { case_sensitive: false, message: "is already taken" }, presence:true

    validates :roll, uniqueness: { message: "must be unique" }, numericality: { only_integer: true, greater_than: 0 },presence:true

    validates :dateofbirth, presence: true

    validates :mobile, presence: true, uniqueness: { message: "mobile number already exist" }

end
