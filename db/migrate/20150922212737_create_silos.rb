class CreateSilos < ActiveRecord::Migration
  def change
    create_table :silos do |t|
      t.string :name
    end
  end
end
