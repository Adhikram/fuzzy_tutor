module PaperElementsHelper
  def paper_element_params
    params.require(:data)
          .require(:attributes)
          .permit(
            :element_type,
            :text,
            :link,
            :marks,
            :negative_marks,
            :parent_id,
            :paper_id,
            meta_data: [] # Permit meta_data as an array
          )
  end

  def allowed_paper_element_attributes
    %i[element_type text link marks negative_marks meta_data parent_id paper_id]
  end
end
