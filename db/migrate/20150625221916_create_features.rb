class CreateFeatures < ActiveRecord::Migration
  def change
    create_table :features do |t|
      t.string :name
      t.references :sheet, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
