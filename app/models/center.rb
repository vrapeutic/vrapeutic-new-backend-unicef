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
end
