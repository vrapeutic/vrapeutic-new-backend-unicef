class Child < ApplicationRecord

    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
    validates :age, numericality: {
        only_integer: true,
        greater_than_or_equal_to: 6,
        less_than_or_equal_to: 40,
        allow_nil: true
      }
end
