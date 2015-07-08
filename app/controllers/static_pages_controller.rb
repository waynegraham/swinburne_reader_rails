class StaticPagesController < ApplicationController
  def home
    @poems = Poem.all
  end

  def about
  end
end
