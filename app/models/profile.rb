class Profile < ApplicationRecord
  belongs_to :user
  
  validates :introduction, length: { maximum: 500 }
  validates :location, length: { maximum: 100 }
end
