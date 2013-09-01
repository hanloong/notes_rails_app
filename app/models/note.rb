class Note < ActiveRecord::Base
  validates_presence_of :note

  scope :by_user,      -> (user_id) { where(user_id: user_id) }
end
