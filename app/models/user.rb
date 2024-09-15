class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :messages
  scope :all_except, ->(user) { where.not(id: user) }

  after_create_commit { broadcast_append_to "users"}
  has_one_attached :image
  after_commit :set_default_image, on: [:create, :update]
  private

  def set_default_image
    unless image.attached?
      image.attach(io: File.open(Rails.root.join("app", "assets", "images", "default_image.png")), filename: "default_image.png", content_type: "image/png")
    end
  end
end
