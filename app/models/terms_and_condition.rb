class TermsAndCondition < ActiveRecord::Base
  has_many :accepts, dependent: :destroy
  has_many :users, through: :accepts
  validates_presence_of :title
  validates_presence_of :body
  before_save :reset_accepts

  scope :not_accepted_by, -> (user_id) { where.not(id: Accept.where(user_id: user_id).select("CAST (terms_and_condition_id as INTEGER)")) }

  def reset_accepts
    if self.changed?
      self.accepts.each do |accept|
        accept.destroy
      end
    end
  end
end
