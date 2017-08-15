class CollaborationsController < ApplicationController
  before_action :set_collaboration, only: [:show, :edit, :update, :destroy]

  # GET /collaborations
  # GET /collaborations.json
  def index
    @collaborations = Collaboration.all

  end

  # GET /collaborations/1
  # GET /collaborations/1.json
  def show
    @wiki = Wiki.find(params[:id])
  end

  # GET /collaborations/new
  def new
    @collaboration = Collaboration.new
  end

  # GET /collaborations/1/edit
  def edit
#    @collaboration = Collaboration.find(params[:id])

  end

  # POST /collaborations
  # POST /collaborations.json
  def create
    @collaboration = Collaboration.new(collaboration_params)
    @collaboration.user = params[:collaboration][:user]
    @collaboration.wiki = params[:collaboration][:wiki]

    respond_to do |format|
      if @collaboration.save
        format.html { redirect_to @collaboration, notice: 'Collaboration was successfully created.' }
        format.json { render :show, status: :created, location: @collaboration }
      else
        format.html { render :new }
        format.json { render json: @collaboration.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /collaborations/1
  # PATCH/PUT /collaborations/1.json
  def update

    collaborations = Collaboration.where(wiki_id: params[:id])
    collaborations.each do |collaboration|
      collaboration.destroy!
    end

    params[:email].each do |user_email|
      unless user_email.empty?
        if User.all.include?(User.find_by(email: user_email))
          user_id = User.find_by(email: user_email).id
          collaboration = Collaboration.new(
          user_id: user_id,
          wiki_id: params[:id]
          )

          if collaboration.save!

          else
            flash[:alert] = "collaboration save failed"
          end
        else
          flash[:alert] = "#{user_email} is not a valid email"
        end
      end
    end
    if params[:collaboration]
      params[:collaboration][:user_id_array].each do |user_id|
        collaboration = Collaboration.new(
        user_id: user_id,
        wiki_id: params[:id]
        )
        if collaboration.save!

        end
      end
    end
    redirect_to show_collaborations_for_wiki_path(params[:id])
  end
  # DELETE /collaborations/1
  # DELETE /collaborations/1.json
  def destroy
    @collaboration.destroy
    respond_to do |format|
      format.html { redirect_to collaborations_url, notice: 'Collaboration was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_collaboration
      @collaboration = Collaboration.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def collaboration_params
      params.fetch(:user, :wiki)
    end
end
