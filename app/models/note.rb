class Note < ActiveRecord::Base
  scope :by_user,      -> (user_id) { where(user_id: user_id) }
end
