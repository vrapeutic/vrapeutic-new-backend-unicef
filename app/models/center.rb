class Center < ApplicationRecord

    validates :latitude, presence: true, numericality: { greater_than_or_equal_to: -90, less_than_or_equal_to: 90 }
    validates :longitude, presence: true, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }
    validates :name, presence: true
    validates :website, uniqueness: true
    validates :logo, presence: true
    validates :certificate, presence: true
    validates :registration_number, presence: true, uniqueness: true
    validates :tax_id, presence: true, uniqueness: true


    mount_uploader :logo, PhotoUploader
    mount_uploader :certificate, CertificateUploader

    has_many :doctor_centers, dependent: :destroy
    has_many :doctors, through: :doctor_centers
    has_many :center_specialties, dependent: :destroy
    has_many :specialties, through: :center_specialties
    has_many :center_social_links, dependent: :destroy
end
