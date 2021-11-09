class User < ApplicationRecord
  has_secure_password
  has_one_attached :profile_photo
end
