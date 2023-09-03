class Center::AddChildService

    def initialize(name:, email:, age: nil, center_id:, diagnosis_ids: [])
        @name = name
        @email = email
        @age = age
        @center_id = center_id
        @diagnosis_ids = diagnosis_ids
    end

    def call 
        Child.transaction do 
            create_child
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
        @new_child = Child.create!(options)
    end
end