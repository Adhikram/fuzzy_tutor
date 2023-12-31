class PaperElement < ApplicationRecord
  include ApplicationHelper
  belongs_to :paper, optional: true
  belongs_to :parent, class_name: 'PaperElement', optional: true
  has_many :children, class_name: 'PaperElement', foreign_key: 'parent_id'
  serialize :meta_data, Array
  enum :element_type, %i[section question answer]

  def calculate_result(metadata, result_metadata = {})
    total_sum = 0
    byebug

    if metadata[id].present?
      if element_type == 'section'
        children = PaperElement.where(parent_id: id)
        section_sum = 0

        children.each do |child|
          section_result, result_metadata = calculate_result(metadata[id], child.result_metadata)
          section_sum += section_result
          result_metadata[id] = section_sum
        end

        total_sum += section_sum
      elsif element_type == 'question'
        # Assuming metadata contains the required information
        if metadata == metadata[id]
          total_sum += marks
        else
          # Assuming negative_marks is retrieved from a source
          negative_marks = fetch_negative_marks(metadata[id])
          total_sum -= negative_marks
        end
      end
    end

    [total_sum, result_metadata]
  end

  def get_preview_data
    return slice(:id, :element_type, :text, :link, :parent_id) if element_type == 'answer'

    metadata = slice(:id, :element_type, :text, :link, :marks, :negative_marks, :meta_data, :parent_id, :paper_id)
    metadata[:children] = []
    children.each do |child|
      metadata[:children] << child.get_preview_data
    end
    metadata
  end
end
