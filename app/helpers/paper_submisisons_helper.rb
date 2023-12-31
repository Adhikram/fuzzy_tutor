module PaperSubmisisonsHelper
    def paper_submission_params
        params.require(:data)
        .require(:attributes)
        .permit(
            :paper_slug,
            :started_at,
            meta_data: [] # Permit meta_data as an array
        )
    end

    def allowed_paper_submmision_attributes
        %i[submission_slug user_id paper_slug started_at meta_data score is_best_submission result_metadata]
    end
end
