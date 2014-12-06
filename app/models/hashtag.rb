class Hashtag < ActiveRecord::Base
	validates_uniqueness_of :name
	has_many :posts

	# def create
	# 	hashtag = Hashtag.create(name: )
	# end
end
