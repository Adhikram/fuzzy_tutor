class Course < ApplicationRecord
  belongs_to :user
  has_many :papers
  enum course_type: %i[free paid]
  before_save :update_slug, if: :name_changed?

  private

  def update_slug
    self.slug = "#{name.parameterize}-#{Digest::SHA1.hexdigest([Time.now, rand].join)[0, 6]}"
  end
end
