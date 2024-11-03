class HomeKidSerializer < BaseSerializer
  attributes :name, :age, :join_date, :number_of_sessions

  attribute :severity do |child|
    average_evaluation = child.as_json['average_evaluation']

    if average_evaluation.nil?
      'Unknown'
    else
      # Round the value to the nearest integer
      rounded_value = average_evaluation.to_f.round

      # Map the rounded value to the corresponding enum value from your model
      Session.evaluations.key(rounded_value)
    end
  end

  has_many :diagnoses, if: proc { |_record, params| BaseSerializer.params_include?(params, 'diagnoses') && params[:center_id] } do |child, params|
    diagnoses_ids = child.child_diagnoses.where(center_id: params[:center_id]).pluck(:diagnosis_id)
    Diagnosis.where(id: diagnoses_ids)
  end
  has_many :centers, if: proc { |_record, params| BaseSerializer.params_include?(params, 'centers') }
  has_many :software_modules, if: proc { |_record, params| BaseSerializer.params_include?(params, 'software_modules') }
  has_many :sessions, if: proc { |_record, params| BaseSerializer.params_include?(params, 'sessions') }
  has_many :doctors, if: proc { |_record, params| BaseSerializer.params_include?(params, 'doctors') }
end
