class CollaborationsController < ApplicationController
  # GET /collaborations/1

  def show
    authorize Collaboration
    @wiki = Wiki.find(params[:id])

  end

  # GET /collaborations/new
  # def new
  #   @collaboration = Collaboration.new
  # end



  # POST /collaborations

  # def create
  #   @collaboration = Collaboration.new(collaboration_params)
  #   @collaboration.user = params[:collaboration][:user]
  #   @collaboration.wiki = params[:collaboration][:wiki]
  #
  #   respond_to do |format|
  #     if @collaboration.save
  #       format.html { redirect_to @collaboration, notice: 'Collaboration was successfully created.' }
  #     else
  #       format.html { render :new }
  #     end
  #   end
  # end

  # PATCH/PUT /collaborations/1
  # PATCH/PUT /collaborations/1.json
  def update
    authorize Collaboration
    @wiki = Wiki.find(params[:id])

    # delete all collaborators
    collaborations = Collaboration.where(wiki_id: @wiki.id)
    collaborations.each do |collaboration|
      collaboration.destroy!
    end

    # collaborators from checkboxes
    if params[:collaboration]
      params[:collaboration][:user_id_array].each do |user_id|
        if !Collaboration.all.include?(user_id: user_id)
          collaboration = Collaboration.new(
          user_id: user_id,
          wiki_id: @wiki.id
          )
          unless collaboration.save!
            flash[:alert] = "collaboration save failed"
          end
        end
      end
    end
    # collaborators from text input
    params[:email].each do |user_email|
      unless user_email.empty?
        user = User.find_by(email: user_email)
        if User.all.include?(user) && !@wiki.users.include?(user)
          collaboration = Collaboration.new(
          user_id: user.id,
          wiki_id: @wiki.id
          )
          unless collaboration.save!
            flash[:alert] = "collaboration save failed"
          end
        else
          flash[:alert] = "#{user_email} is not a valid email"
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
    # def set_collaboration
    #   @collaboration = Collaboration.find(params[:id])
    # end

    # Never trust parameters from the scary internet, only allow the white list through.
    # def collaboration_params
    #   params.fetch(:user, :wiki)
    # end
end
