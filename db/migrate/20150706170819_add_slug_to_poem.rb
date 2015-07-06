class AddSlugToPoem < ActiveRecord::Migration
  def change
    add_column :poems, :slug, :string

    add_index :poems, :slug
  end
end
