class PaperElement < ApplicationRecord
  belongs_to :paper, optional: true
  belongs_to :parent, class_name: 'PaperElement', optional: true
  serialize :meta_data, Hash
  enum :element_type, %i[section question answer]
end
