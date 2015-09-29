class Event < ActiveRecord::Base

	has_many :tickets , dependent: :destroy
	belongs_to :user, :foreign_key => "user_id"
end
