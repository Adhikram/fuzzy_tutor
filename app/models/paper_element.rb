class PaperElement < ApplicationRecord
  include ApplicationHelper
  belongs_to :paper, optional: true
  belongs_to :parent, class_name: 'PaperElement', optional: true
  has_many :children, class_name: 'PaperElement', foreign_key: 'parent_id'
  serialize :meta_data, Array
  enum :element_type, %i[section question answer]

  def calculate_result(metadata)
    puts("Calculating result for #{id} #{text} #{metadata}")
    total_sum = 0
    result_metadata = {} if result_metadata.blank?

    if metadata[id].present?
      if element_type == 'section'
        section_sum = 0

        result_metadata[id] = {}
        result_metadata[id][:meta_data] = []
        children.each do |child|
          section_result, child_metadata = child.calculate_result(metadata[id])
          section_sum += section_result
          result_metadata[id][:meta_data] << child_metadata
        end
        result_metadata[id][:total] = section_sum

        total_sum += section_sum
      elsif element_type == 'question'
        # Assuming metadata contains the required information
        if meta_data == metadata[id]
          total_sum += marks
        else
          # Assuming negative_marks is retrieved from a source
          negative_marks = 1 if meta_data.size > 1
          total_sum -= marks / negative_marks
        end
        result_metadata = { id: id, answer: meta_data, input: metadata[id] }
      end
    end

    puts("Result for #{id} #{text} is #{total_sum} #{result_metadata}")
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

  def get_answer_preview
    return meta_data if element_type == 'question'

    metadata = {}
    children.each do |child|
      metadata[child.id] = child.get_answer_preview
    end
    metadata
  end
end
