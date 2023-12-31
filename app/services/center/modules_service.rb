class Center::ModulesService 
    # get all modules that the center can use 

    def initialize(center: )
        @center = center
    end

    def call 
        asssigned_modules
    end

    private

    def asssigned_modules 
        @center.software_modules.includes(:targeted_skills)
    end
end