class ImagesController < ApplicationController


  # GET /images

  def index
    @images = Image.all
  end

  # GET /images/1

  def show
  end

  # GET /images/new
  def new
    @image = Image.new
  end

  # GET /images/1/edit
  def edit
  end

  # POST /images

  def create
    @image = Image.new(image_params)

    respond_to do |format|
      if @image.save
        format.html { redirect_to @image, notice: 'Image was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /images/1

  def update
    respond_to do |format|
      if @image.update(image_params)
        format.html { redirect_to @image, notice: 'Image was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /images/1

  def destroy
    @image.destroy
    respond_to do |format|
      format.html { redirect_to images_url, notice: 'Image was successfully destroyed.' }
    end
  end

  private

    def set_image
      @image = Image.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def image_params
      params.fetch(:image, {})
    end
end
