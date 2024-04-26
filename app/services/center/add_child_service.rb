class Center::AddChildService

    def initialize(name:, email:, age: nil, photo: nil, center_id:, diagnosis_ids: [])
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
        rescue => e
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
        @new_child.diagnoses << @diagnoses_records
    end

    def create_child_center
        ChildCenter.create!(child: @new_child, center_id: @center_id)
    end
end
