# app/controllers/lists_controller.rb
class ListsController < ApplicationController
  def index
    @lists = List.all
  end

  def show
    @list = List.find(params[:id])
    @bookmark = Bookmark.new
    @bookmarks = @list.bookmarks.where.not(id: nil).includes(:movie)  # # 预加载电影数据
  end

  def new
    @list = List.new
  end

  # def create
  #   @list = List.new(list_params)
  #   if @list.save
  #     redirect_to list_path(@list), notice: "List created successfully!"
  #   else
  #     render :new, status: :unprocessable_entity
  #   end
  # end
  def create
    @list = List.find(params[:list_id])
    @bookmark = @list.bookmarks.build(bookmark_params)

    if @bookmark.save
      redirect_to list_path(@list), notice: "Movie added successfully!"
    else
      @list.reload
      @bookmarks = @list.bookmarks.includes(:movie)
      render "lists/show", status: :unprocessable_entity
    end
  end

  private

  def list_params
    params.require(:list).permit(:name)
  end
end
