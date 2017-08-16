class WikisController < ApplicationController
  def index

    @public_wikis = Wiki.all_access
    @all_private_wikis = Wiki.limited_access
    @my_private_wikis = []

    @collaboration_wikis = []

    if current_user.present?
      @my_private_wikis = Wiki.created_by(current_user.id).limited_access
      collaborations = Collaboration.where(user_id: current_user.id)
      collaborations.each do |collaboration|
        @collaboration_wikis << Wiki.find(collaboration.wiki_id)
      end
    end




  end

  def show
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def new
    @wiki = Wiki.new
    authorize @wiki
  end

  def create
    @wiki = Wiki.new
    authorize @wiki

    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    @wiki.user_id = current_user.id
    if params[:wiki][:private]
     @wiki.private = params[:wiki][:private]
    end




    if @wiki.save
      flash[:notice] = "Wiki was saved."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving the wiki. Please try again."
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])

    authorize @wiki
  end

  def update
    @wiki = Wiki.find(params[:id])

    authorize @wiki

    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    @wiki.private = params[:wiki][:private]

    if @wiki.save
      flash[:notice] = "Wiki was updated."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving the wiki. Please try again."
      render :edit
    end
  end

  def destroy

    @wiki = Wiki.find(params[:id])

    authorize @wiki

    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to wikis_path
    else
      flash.now[:alert] = "There was an error deleting the wiki."
      render :show
    end
  end
end
