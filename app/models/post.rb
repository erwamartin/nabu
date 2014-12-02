class Post < ActiveRecord::Base
  belongs_to :hashtag_id, :class_name => 'Hashtag'
end
