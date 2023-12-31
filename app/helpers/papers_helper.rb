module PapersHelper
  def paper_params
    params.require(:data)
          .require(:attributes)
          .permit(:title, :description, :active_status, :resource_link, :paper_type, :course_id, :paper_element_id)
  end

  def allowed_paper_attributes
    %i[id title description active_status resource_link paper_type slug course_id user_id paper_element_id]
  end
end
