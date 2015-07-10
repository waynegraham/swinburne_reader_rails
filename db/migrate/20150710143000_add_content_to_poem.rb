class AddContentToPoem < ActiveRecord::Migration
  def change
    add_column :poems, :content, :text
  end
end
