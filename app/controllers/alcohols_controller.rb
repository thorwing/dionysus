class AlcoholsController < ApplicationController
  # GET /alcohols
  # GET /alcohols.json
  def index
    @alcohols = Alcohol.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @alcohols }
    end
  end

  # GET /alcohols/1
  # GET /alcohols/1.json
  def show
    @alcohol = Alcohol.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @alcohol }
    end
  end

  # GET /alcohols/new
  # GET /alcohols/new.json
  def new
    @alcohol = Alcohol.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @alcohol }
    end
  end

  # GET /alcohols/1/edit
  def edit
    @alcohol = Alcohol.find(params[:id])
  end

  # POST /alcohols
  # POST /alcohols.json
  def create
    @alcohol = Alcohol.new(params[:alcohol])

    respond_to do |format|
      if @alcohol.save
        format.html { redirect_to @alcohol, notice: 'Alcohol was successfully created.' }
        format.json { render json: @alcohol, status: :created, location: @alcohol }
      else
        format.html { render action: "new" }
        format.json { render json: @alcohol.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /alcohols/1
  # PUT /alcohols/1.json
  def update
    @alcohol = Alcohol.find(params[:id])

    respond_to do |format|
      if @alcohol.update_attributes(params[:alcohol])
        format.html { redirect_to @alcohol, notice: 'Alcohol was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @alcohol.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /alcohols/1
  # DELETE /alcohols/1.json
  def destroy
    @alcohol = Alcohol.find(params[:id])
    @alcohol.destroy

    respond_to do |format|
      format.html { redirect_to alcohols_url }
      format.json { head :no_content }
    end
  end
end
