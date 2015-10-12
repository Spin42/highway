class Silo < ActiveRecord::Base
  has_many :contact_people, dependent: :destroy
  validates :name, :number, presence: true
  validates :number, uniqueness: true
end
