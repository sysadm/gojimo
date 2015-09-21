class Qualification < ActiveRecord::Base
  belongs_to :country
  has_many :subjects, through: :scientific_sets
  has_many :scientific_sets

  scope :not_empty, -> { where("subjects_count > 0").order(:country_id, :name) }
end
