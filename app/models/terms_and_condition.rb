class TermsAndCondition < ActiveRecord::Base
  has_many :accepts, dependent: :destroy
  has_many :users, through: :accepts

  scope :not_accepted_by, -> (user_id) { where.not(id: Accept.where(user_id: user_id).select("CAST (terms_and_condition_id as INTEGER)")) }
end
