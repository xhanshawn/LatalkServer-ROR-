json.extract! @message, :id, :message_type, :content, :longitude, :latitude, :hold_time, :created_at, :updated_at,  :race_num, :start_id, :like_num, :dislike_num

json.image_url @message.image_url
json.thumb_url @message.image_url(:thumb)
json.small_thumb_url @message.image_url(:small_thumb)