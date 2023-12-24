module CoursesHelper
  def course_params
    params.require(:data)
          .require(:attributes)
          .permit(:name, :description, :active_status, :course_type)
  end

  def allowed_course_attributes
    %i[name description active_status course_type slug created_at updated_at]
  end
end
