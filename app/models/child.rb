class Child < ApplicationRecord

    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
    validates :age, numericality: {
        only_integer: true,
        greater_than_or_equal_to: 6,
        less_than_or_equal_to: 40,
        allow_nil: true
      }

    has_many :child_diagnoses, dependent: :destroy
    has_many :diagnoses, through: :child_diagnoses
    has_many :child_centers, dependent: :destroy
    has_many :centers, through: :child_centers
    has_many :child_software_modules, dependent: :destroy
    has_many :software_modules, through: :child_software_modules
    has_many :child_doctors, dependent: :destroy 
    has_many :doctors, through: :child_doctors
end
