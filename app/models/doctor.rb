class Doctor < ApplicationRecord
    has_secure_password

    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
    validates :password, length: { minimum: 6 }
    validates :university, presence: true
    validates :degree, presence: true

    has_many :doctor_specialties, dependent: :destroy
    has_many :specialties, through: :doctor_specialties
end
