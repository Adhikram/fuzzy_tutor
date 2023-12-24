class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :authentication_keys => [:email, :phone_number]

  enum user_type: %i[student teacher admin]


  def fetch_courses
    if user_type != 'student'
      Course.all
    else
      Course.where(active_status: true).order(updated_at: :desc)
    end
  end
end
