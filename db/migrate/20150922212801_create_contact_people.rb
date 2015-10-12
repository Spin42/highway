class CreateContactPeople < ActiveRecord::Migration
  def change
    create_table :contact_people do |t|
      t.references :silo
      t.string :name
      t.string :phone_number
    end
  end
end
