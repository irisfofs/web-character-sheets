class Sheet < ActiveRecord::Base
  has_many :statistics
  has_many :features
  validates :name, presence: true,
                   length: { minimum: 4 }

end
