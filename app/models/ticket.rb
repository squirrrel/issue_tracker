class Ticket < ActiveRecord::Base
	attr_accessor :editable, :owner

	belongs_to :engineer
	has_many :comments

	validates :body, presence: true
	validates :customer_name, presence: true
	validates :customer_email, presence: true
	validates :department, presence: true
	validates :subject, presence: true
end
