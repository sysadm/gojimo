class Qualification < ActiveRecord::Base
  belongs_to :country
  has_many :subjects

  scope :not_empty, -> { where("subjects_count > 0") }
end
