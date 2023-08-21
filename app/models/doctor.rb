class Doctor < ApplicationRecord
    has_secure_password

    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
    validates :password, length: { minimum: 6 }
    validates :university, presence: true
    validates :degree, presence: true
end
