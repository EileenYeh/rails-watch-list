class BookmarksController < ApplicationController

    # 不需要 index 和 show 方法（根据路由配置）
  # def index
  #   @bookmarks = Bookmark.all
  # end

  # def show
  #   @bookmark = Bookmark.find(params[:id])
  # end

  def new
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new
  end

  # def create
  #   @list = List.find(params[:list_id])
  #   @bookmark = @list.bookmarks.build(bookmark_params)

  #   if @bookmark.save
  #     redirect_to list_path(@list), notice: "Movie added successfully!"
  #   else
  #     # 如果是从 list show 页面提交，需要重新加载 @list 的书签
  #     @list.reload  # ✅ 重新加载 list 和其关联
  #     @bookmarks = @list.bookmarks.includes(:movie)
  #   end
  # end

  def create
    @list = List.find(params[:list_id])
    @bookmark = @list.bookmarks.build(bookmark_params)

    if @bookmark.save
      redirect_to list_path(@list), notice: "Movie added successfully!"
    else
      # 添加调试输出
      puts "=== VALIDATION ERRORS ==="
      puts @bookmark.errors.full_messages
      puts "========================="

      @list.reload
      @bookmarks = @list.bookmarks.includes(:movie)
      render "lists/show", status: :unprocessable_entity
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    redirect_to list_path(@bookmark.list), notice: "Bookmark deleted"
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id)  # ✅ 包含 movie_id
  end
end
