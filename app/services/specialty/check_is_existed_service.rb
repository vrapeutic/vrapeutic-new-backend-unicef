class Specialty::CheckIsExistedService 

    def initialize(specialty_ids:)
        @specialty_ids = specialty_ids
    end

    def call 
        check_if_existed
    end

    private

    def check_if_existed
        error_message = 'specialties not found, please provide at least one'
        raise error_message if @specialty_ids.nil? 
        @specialty_ids = @specialty_ids.reject { |element| element.empty? }
        raise error_message if @specialty_ids.length == 0
    end
end