class LinksController < ApplicationController
  include Linkable

  before_action :set_link, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /links or /links.json
  def index
    @links = current_user.links.page(params[:page]).per(5)
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
    @link = @link.becomes(Link)
  end

  # POST /links or /links.json
  def create
    @link = current_user.links.build(link_params)

    respond_to do |format|
      if @link.save
        format.html { redirect_to link_url(@link), flash: { success: "Link was successfully created." }}
        format.json { render :show, status: :created, location: @link }
      else
        @link = @link.becomes(params[:type].constantize)
        format.json { render json: @link.errors, status: :unprocessable_entity }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /links/1 or /links/1.json
  def update
    respond_to do |format|
      @link = @link.becomes(params[:link][:type].constantize)
      if @link.update(link_params)
        format.html { redirect_to link_url(@link), success: "Link was successfully updated." }
        format.json { render :show, status: :ok, location: @link }
      else
        @link = @link.becomes(Link)
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /links/1 or /links/1.json
  def destroy
    @link.destroy!

    respond_to do |format|
      format.html { redirect_to links_url, flash: { success: "Link was successfully destroyed." }}
      format.json { head :no_content }
    end
  end

  private

  def link_params
    params.require(:link).permit(:url, :name, :type, :password, :expiration_date)
  end
  
end
