class Doctor < ApplicationRecord
    has_secure_password

    validates :name, presence: true
    validates :photo, presence: true
    validates :email, presence: true, uniqueness: true
    validates :password, length: { minimum: 6 }
    validates :university, presence: true
    validates :degree, presence: true
    validates :certificate, presence: true

    has_many :doctor_specialties, dependent: :destroy
    has_many :specialties, through: :doctor_specialties
    has_one :otp, dependent: :destroy

    mount_uploader :photo, PhotoUploader
    mount_uploader :certificate, CertificateUploader

    has_many :doctor_centers, dependent: :destroy
    has_many :centers, through: :doctor_centers
end
