class Hashtag < ActiveRecord::Base
	validates_uniqueness_of :name
	has_many :posts

	# def create
	# 	hashtag = Hashtag.create(name: )
	# end

	def self.get_id_hashtag_if_exist_or_not(name)
		if Hashtag.exists?(name: name)
	      hashtag = Hashtag.find_by_name(name)
	      htag_id = hashtag.id
	    else
	      hashtag = Hashtag.create(name: name)
	      htag_id = hashtag.id
	    end
	end
end
