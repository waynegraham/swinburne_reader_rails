class AddImageToPoem < ActiveRecord::Migration
  def change
    add_column :poems, :image, :string
  end
end
