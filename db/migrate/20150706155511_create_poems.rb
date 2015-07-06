class CreatePoems < ActiveRecord::Migration
  def change
    create_table :poems do |t|
      t.string :title

      t.timestamps null: false
    end
  end
end
