class MotorPerformance < ApplicationRecord
    has_one :performance, as: :performanceable
end
