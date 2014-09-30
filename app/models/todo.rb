class Todo < ActiveRecord::Base
	validates :description, presence: true
end
