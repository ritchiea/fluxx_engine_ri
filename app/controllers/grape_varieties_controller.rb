class GrapeVarietiesController < ApplicationController
  # GET /grape_varieties
  # GET /grape_varieties.xml
  def index
    @grape_varieties = GrapeVariety.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @grape_varieties }
    end
  end

  # GET /grape_varieties/1
  # GET /grape_varieties/1.xml
  def show
    @grape_variety = GrapeVariety.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @grape_variety }
    end
  end

  # GET /grape_varieties/new
  # GET /grape_varieties/new.xml
  def new
    @grape_variety = GrapeVariety.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @grape_variety }
    end
  end

  # GET /grape_varieties/1/edit
  def edit
    @grape_variety = GrapeVariety.find(params[:id])
  end

  # POST /grape_varieties
  # POST /grape_varieties.xml
  def create
    @grape_variety = GrapeVariety.new(params[:grape_variety])

    respond_to do |format|
      if @grape_variety.save
        format.html { redirect_to(@grape_variety, :notice => 'Grape variety was successfully created.') }
        format.xml  { render :xml => @grape_variety, :status => :created, :location => @grape_variety }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @grape_variety.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /grape_varieties/1
  # PUT /grape_varieties/1.xml
  def update
    @grape_variety = GrapeVariety.find(params[:id])

    respond_to do |format|
      if @grape_variety.update_attributes(params[:grape_variety])
        format.html { redirect_to(@grape_variety, :notice => 'Grape variety was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @grape_variety.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /grape_varieties/1
  # DELETE /grape_varieties/1.xml
  def destroy
    @grape_variety = GrapeVariety.find(params[:id])
    @grape_variety.destroy

    respond_to do |format|
      format.html { redirect_to(grape_varieties_url) }
      format.xml  { head :ok }
    end
  end
end
