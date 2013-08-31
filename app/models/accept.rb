class Accept < ActiveRecord::Base
  belongs_to :user
  belongs_to :terms_and_condition
end
