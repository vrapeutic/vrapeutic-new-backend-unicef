class CreateMotorPerformances < ActiveRecord::Migration[7.0]
  def change
    create_table :motor_performances do |t|
      t.integer :speed
      t.integer :response

      t.timestamps
    end
  end
end
