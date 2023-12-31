class Paper < ApplicationRecord
  belongs_to :user
  belongs_to :course
  has_one :paper_element
  enum :paper_type, %i[free paid]
  before_save :update_slug, if: :title_changed?
  before_create :add_main_section

  private

  def update_slug
    self.slug = "#{title.parameterize}-#{Digest::SHA1.hexdigest([Time.now, rand].join)[0, 6]}"
  end

  def add_main_section
    paper_element = PaperElement.create!(element_type: 0, text: title, paper_id: id)
    self.paper_element_id = paper_element.id
  end
end
