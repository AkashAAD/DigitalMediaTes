class CreateLibraries < ActiveRecord::Migration[5.2]
  def change
    create_table :libraries do |t|
      t.belongs_to :user
      t.belongs_to :option
      t.references :contentable, polymorphic: true
      t.timestamps
    end
  end
end
