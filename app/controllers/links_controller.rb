class LinksController < ApplicationController
  before_action :set_link, only: %i[ show edit update destroy ]

  # GET /links or /links.json
  def index
    @links = current_user.links
    if @links.empty?
      flash[:info] = "You don't have any links yet. Create one!"
    end

  end

  # GET /links/1 or /links/1.json
  def show
    @link = Link.where(id: params[:id], user: current_user).first
  end

  # GET /links/new
  def new
    @link = current_user.links.build
    @link.type = params[:type]
  end

  # GET /links/1/edit
  def edit
  end

  # POST /links or /links.json
  def create
    @link = current_user.links.new(link_params)
    @link.type = params[:type]

    respond_to do |format|
      if @link.save
        format.html { redirect_to link_url(@link), success: "Link was successfully created." }
        format.json { render :show, status: :created, location: @link }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @link.errors, status: :unprocessable_entity }
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
    # Use callbacks to share common setup or constraints between actions.
    def set_link
      begin
      @link = Link.find(params[:id], user_id: current_user.id)
      rescue ActiveRecord::RecordNotFound
        redirect_to links_path, alert: 'Link not found.'
      end
    end

    # Only allow a list of trusted parameters through.
    def link_params
      params.require(:link).permit(:url, :slug, :name, :type, :password, :expiration_date)
    end
end
