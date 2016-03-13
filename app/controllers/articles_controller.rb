class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end
  def show
    @article = Article.find(params[:id])
  end
  def new
    @article = Article.new
  end
  def create
    # Make the new article record
    puts 'Creating article'
    @article = Article.create(article_params)

    if @article.save
      flash[:notice] = "Article was successfully created."
      redirect_to articles_path
    else
      flash.now[:error] = "An error prevented the article from being created."
      render :new
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to articles_path, notice: "Article was successfully updated."
    else
      flash.now[:alert] = "Article was not updated."
      render :edit
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path
  end

  private

  def article_params
    # Return a filtered params hash with only the attributes we allow through
     params.require(:article).permit(:title, :body)
  end

end
