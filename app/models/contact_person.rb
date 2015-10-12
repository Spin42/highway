class ContactPerson < ActiveRecord::Base
  belongs_to :silo
  validates :name, :phone_number, presence: true
end
