class Course < ApplicationRecord
  belongs_to :user
  enum course_type: %i[free paid]

end
