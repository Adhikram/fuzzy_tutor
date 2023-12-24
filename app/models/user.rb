class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         authentication_keys: %i[email phone_number]

  enum user_type: %i[student teacher admin]
  has_many :courses
  has_many :papers

  def fetch_courses
    if user_type != 'student'
      Course.all
    else
      Course.where(active_status: true).order(updated_at: :desc)
    end
  end

  def fetch_papers(course_id)
    papers = if user_type != 'student'
               Paper.where(course_id: course_id)
             else
               Paper.where(active_status: true, course_id: course_id)
             end
    papers.order(updated_at: :desc)
  end
end
