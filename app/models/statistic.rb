class Statistic < ActiveRecord::Base
  belongs_to :sheet

  validates :name, presence: true
end
