class Center::AddChildService
  def initialize(name:, email:, center_id:, age: nil, photo: nil, diagnosis_ids: [])
    @name = name
    @email = email
    @age = age
    @photo = photo
    @center_id = center_id
    @diagnosis_ids = diagnosis_ids
  end

  def call
    check_diagnoses_existed
    Child.transaction do
      create_child
      create_chid_diagnoses
      create_child_center
      @new_child
    end
  rescue StandardError => e
    raise e
  end

  private

  def create_child
    options = {
      name: @name,
      email: @email.downcase
    }
    options[:age] = @age unless @age.nil?
    options[:photo] = @photo unless @photo.nil?
    @new_child = Child.create!(options)
  end

  def check_diagnoses_existed
    @diagnoses_records = Diagnosis::CheckIsExistedService.new(diagnosis_ids: @diagnosis_ids).call
  end

  def create_chid_diagnoses
    @diagnoses_records.each do |diagnoses_record|
      ChildDiagnosis.create!(diagnosis: diagnoses_record, center_id: @center_id, child: @new_child)
    end
  end

  def create_child_center
    ChildCenter.create!(child: @new_child, center_id: @center_id)
  end
end
