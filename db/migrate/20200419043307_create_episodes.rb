class CreateEpisodes < ActiveRecord::Migration[5.2]
  def change
    create_table :episodes do |t|
      t.string :title
      t.text :plot
      t.belongs_to :season, foreign_key: true
      t.timestamps
    end
  end
end
