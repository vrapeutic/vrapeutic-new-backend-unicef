class Admin::EditChildService

    def initialize(child_id:, edit_params:, diagnosis_ids:)
        @child_id = child_id
        @edit_params = edit_params
        @diagnosis_ids = diagnosis_ids
    end

    def call 
        edit_child_with_diagnoses
    end

    private

    def edit_child_with_diagnoses
        Center::EditChildService.new(
            child_id: @child_id, 
            edit_params: @edit_params, 
            diagnosis_ids: @diagnosis_ids
          ).call
    end
end