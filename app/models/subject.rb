class Subject < ActiveRecord::Base
  has_many :qualifications, through: :scientific_sets
  has_many :scientific_sets

end
