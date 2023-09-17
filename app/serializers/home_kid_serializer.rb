class HomeKidSerializer
  include JSONAPI::Serializer
  attributes :name, :age, :join_date, :number_of_sessions

  attribute :severity do |child|
    average_evaluation = (child.as_json['average_evaluation'])
    
    if average_evaluation.nil?
      "Unknown"
    else
      # Round the value to the nearest integer
      rounded_value = average_evaluation.to_f.round

      # Map the rounded value to the corresponding enum value from your model
      Session.evaluations.key(rounded_value)
    end

    
  end
end
