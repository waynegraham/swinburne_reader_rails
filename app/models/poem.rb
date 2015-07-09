class Poem < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged

  def next
    Poem.where("id > ?", id).order('id ASC').first || Poem.first
  end

  def prev
    Poem.where("id > ?", id).order('id DESC').first || Poem.last
  end
end
