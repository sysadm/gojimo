class ScientificSet < ActiveRecord::Base
  belongs_to :qualification
  belongs_to :subject
end
