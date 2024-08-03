class AddEvaluationFileToSessions < ActiveRecord::Migration[7.0]
  def change
    add_column :sessions, :evaluation_file, :string
  end
end
