class TagsController < ApplicationController
  def show
    @tag = Tag.find(params[:id])
    @books = @tag.books
  end
end