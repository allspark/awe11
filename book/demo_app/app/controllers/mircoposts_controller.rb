class MircopostsController < ApplicationController
  # GET /mircoposts
  # GET /mircoposts.xml
  def index
    @mircoposts = Mircopost.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @mircoposts }
    end
  end

  # GET /mircoposts/1
  # GET /mircoposts/1.xml
  def show
    @mircopost = Mircopost.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @mircopost }
    end
  end

  # GET /mircoposts/new
  # GET /mircoposts/new.xml
  def new
    @mircopost = Mircopost.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @mircopost }
    end
  end

  # GET /mircoposts/1/edit
  def edit
    @mircopost = Mircopost.find(params[:id])
  end

  # POST /mircoposts
  # POST /mircoposts.xml
  def create
    @mircopost = Mircopost.new(params[:mircopost])

    respond_to do |format|
      if @mircopost.save
        format.html { redirect_to(@mircopost, :notice => 'Mircopost was successfully created.') }
        format.xml  { render :xml => @mircopost, :status => :created, :location => @mircopost }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @mircopost.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /mircoposts/1
  # PUT /mircoposts/1.xml
  def update
    @mircopost = Mircopost.find(params[:id])

    respond_to do |format|
      if @mircopost.update_attributes(params[:mircopost])
        format.html { redirect_to(@mircopost, :notice => 'Mircopost was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @mircopost.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /mircoposts/1
  # DELETE /mircoposts/1.xml
  def destroy
    @mircopost = Mircopost.find(params[:id])
    @mircopost.destroy

    respond_to do |format|
      format.html { redirect_to(mircoposts_url) }
      format.xml  { head :ok }
    end
  end
end
