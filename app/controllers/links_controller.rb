class LinksController < ApplicationController
  before_action :set_link, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /links or /links.json
  def index
    @links = current_user.links
    
    if @links.empty?
      flash[:notice] = "You don't have any links yet. Create one!"
    end

  end

  # GET /links/1 or /links/1.json
  def show
  end

  # GET /links/new
  def new
    @link = current_user.links.build
  end

  # GET /links/1/edit
  def edit
  end

  # POST /links or /links.json
  def create
    @link = current_user.links.build(link_params)

    respond_to do |format|
      if @link.save
        format.html { redirect_to link_url(@link), success: "Link was successfully created." }
        format.json { render :show, status: :created, location: @link }
      else
        @link = @link.becomes(Link)
        format.json { render json: @link.errors, status: :unprocessable_entity }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /links/1 or /links/1.json
  def update
    respond_to do |format|
      if @link.update(link_params)
        format.html { redirect_to link_url(@link), success: "Link was successfully updated." }
        format.json { render :show, status: :ok, location: @link }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /links/1 or /links/1.json
  def destroy
    @link.destroy!

    respond_to do |format|
      format.html { redirect_to links_url, notice: "Link was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_link
    @link = Link.find_by(id: params[:id])
    if !user_signed_in?
      flash[:error] = "You need to sign in or sign up before continuing."
      redirect_to new_user_session_path
    elsif !authorized?(@link)
      flash[:error] = "You don't have access to this link."
      redirect_to links_path
    end

  end

  def link_params
    params.require(:link).permit(:url, :slug, :name, :type, :password, :expiration_date)
  end

  def authorized?(link)
    link && link.user_id == current_user.id
  end
  
end
