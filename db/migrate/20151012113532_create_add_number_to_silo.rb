class CreateAddNumberToSilo < ActiveRecord::Migration
  def change
    create_table :add_number_to_silos do |t|
      add_column :silos, :number, :integer
    end
  end
end
