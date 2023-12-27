class PaperElement < ApplicationRecord
  belongs_to :paper, optional: true
  belongs_to :parent, class_name: 'PaperElement', optional: true
  serialize :meta_data, Array
  enum :element_type, %i[section question answer]

  def result(metadata, result_metadata = {})
    total_sum = 0
    byebug
    if metadata[id].present?
      if element_type == 'section'
        children = PaperElement.where(parent_id: id)
        section_sum = 0
        children.each do |child|
          section_sum += child.result(metadata[id])
        end
        result_metadata[id] = section_sum
        total_sum += section_sum
      elsif element_type == 'question'
        # If the question is a Multiple Choice Question then It Currently do not have any negative marks
        negative_marks = 0
        if meta_data == metadata[id]
          total_sum += marks
        else
          total_sum -= negative_marks
        end
      end
    end

    total_sum, result_metadata
  end
end
