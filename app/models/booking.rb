require_relative './concerns/bookable'

class Booking < ActiveRecord::Base
  include Bookable
  belongs_to :student, class_name: 'User', foreign_key: 'student_id'
  has_one :lesson
  belongs_to :topic 



  

  after_create :generate_new_lesson

  def generate_new_lesson
    self.lesson = Lesson.create(uid: SecureRandom.urlsafe_base64(30))
  end  

end