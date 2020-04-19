class CreateSeasons < ActiveRecord::Migration[5.2]
  def change
    create_table :seasons do |t|
      t.string :title
      t.text :plot
      t.integer :no_of_edposodes
      t.timestamps
    end
  end
end
