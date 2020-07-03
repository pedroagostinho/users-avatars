require "open-uri"

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create :validate_photo

  validates :name, presence: true
  # validates :gender, presence: true

  has_one_attached :photo

  GENDERS = ["male", "female"]

  def validate_photo
    unless photo.attached?
      file = URI.open(Faker::Avatar.image)
      photo.attach(io: file, filename: "#{name}.jpg", content_type: 'image/jpg')

      save!
    end
  end
end
