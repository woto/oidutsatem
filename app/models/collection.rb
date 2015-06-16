class Collection < ActiveRecord::Base
  belongs_to :user
  mount_uploader :file, FileUploader
  validates :file, :title, presence: true
end
