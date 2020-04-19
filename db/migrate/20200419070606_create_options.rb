class CreateOptions < ActiveRecord::Migration[5.2]
  def change
    create_table :options do |t|
      t.string :video_quality
      t.decimal :price, precision: 5, scale: 2
      t.references :optionable, polymorphic: true
      t.timestamps
    end
  end
end
