class Ticket < ActiveRecord::Base
	belongs_to :event
	belongs_to :user, dependent: :destroy
end
