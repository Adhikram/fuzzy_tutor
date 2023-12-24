class Paper < ApplicationRecord
  belongs_to :user
  belongs_to :course
  has_one :paper_element
  enum :paper_type, %i[free paid]
  before_save :update_slug, if: :title_changed?

  private

  def update_slug
    self.slug = "#{title.parameterize}-#{Digest::SHA1.hexdigest([Time.now, rand].join)[0, 6]}"
  end
end
