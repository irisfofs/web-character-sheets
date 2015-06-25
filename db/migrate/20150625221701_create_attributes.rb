class CreateAttributes < ActiveRecord::Migration
  def change
    create_table :attributes do |t|
      t.string :name
      t.references :sheet, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
