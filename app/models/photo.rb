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
                    :s3_credentials => S3_CREDENTIALS,
                    :s3_host_name => 's3-us-west-1.amazonaws.com'
  
  attr_accessible :latitude, :longitude, :image
  
  COORDINATE_DELTA = 0.05

  scope :nearby, lambda { |lat, lng|
    where("latitude BETWEEN ? AND ?", lat - COORDINATE_DELTA, lat + COORDINATE_DELTA).
    where("longitude BETWEEN ? AND ?", lng - COORDINATE_DELTA, lng + COORDINATE_DELTA).
    limit(64)
  }
  
  def as_json(options = nil)    
    {
      :latitude => self.latitude,
      :longitude => self.longitude,

      :image_urls => {
        :original => self.image.url,
        :thumbnail => self.image.url(:thumbnail)
      },

      :created_at => self.created_at.iso8601
    }
  end
  
end
