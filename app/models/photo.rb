# == Schema Information
#
# Table name: photos
#
#  id                 :integer          not null, primary key
#  latitude           :decimal(15, 10)
#  longitude          :decimal(15, 10)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#

class Photo < ActiveRecord::Base
  
  has_attached_file :image,
                    :styles => { :thumbnail => "100x100#" },
                    :storage => :s3,
                    :s3_credentials => S3_CREDENTIALS
  
  attr_accessible :latitude, :longitude
  
end
