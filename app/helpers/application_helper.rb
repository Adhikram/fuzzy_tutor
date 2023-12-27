module ApplicationHelper
  include CoursesHelper
  include PapersHelper
  include PaperElementsHelper
  def fetch_id_from_slug(model, slug_key, id_key, params)
    model_data = model.find_by(slug: params[slug_key])
    params.delete(slug_key)
    params[id_key] = (model_data.id if model_data.present?)
  end
end
