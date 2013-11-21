class SeriesController < ApplicationController
  before_action :set_series, only: [:show, :edit, :update, :destroy]
  before_filter :require_user, only: [:show, :edit, :update, :destroy, :index, :new]
  
  # GET /series
  # GET /series.json
  def index
    @series = Serie.all
  end

  def emailpage
    @active = Serie.all
    @series = @active.where(active: true)
  end

  def email
    @ip = request.remote_ip
    @ip2 = request.ip
    @coup = Serie.find_by_name(params[:series][:name])
    @c = Coupon.where(recipient: params[:email][:email])
    if @c != [] 
      redirect_to email_path
    elsif @c == []
      AppMailer.send_coupon_email(params[:email][:email], @coup, @ip, @ip2).deliver
    end
  end

  # GET /series/1
  # GET /series/1.json
  def show
    respond_to do |format|
      format.html
      format.csv { send_data @series.to_csv }
      format.xls # { send_data @products.to_csv(col_sep: "\t") }
    end
  end

  def change
    @series = Serie.find_by_id(params[:id])
    @series.change_method
    # binding.pry
    redirect_to series_index_path
  end


  def activate    
  end
  # GET /series/new
  def new
    @series = Serie.new
  end

  # GET /series/1/edit
  def edit
  end

  # POST /series
  # POST /series.json
  def create
    @series = Serie.new(series_params)
   

    respond_to do |format|
      if @series.save
        @allcoup = params[:allcoupons][:allcoupons]
        @new = @allcoup.split(/\n/)
        @new.each do |x|
        x = x.gsub(/\r/," ")
        x = x.gsub(/\n/," ")
        Coupon.create :serial => x, :serie_id => @series.id 
        end
        
        format.html { redirect_to @series, notice: 'Serie was successfully created.' }
        format.json { render action: 'show', status: :created, location: @series }
      else
        format.html { render action: 'new' }
        format.json { render json: @series.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /series/1
  # PATCH/PUT /series/1.json
  def update
    respond_to do |format|
      if @series.update(series_params)
        format.html { redirect_to @series, notice: 'Serie was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @series.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /series/1
  # DELETE /series/1.json
  def destroy
    @series.destroy
    respond_to do |format|
      format.html { redirect_to series_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_series
      @series = Serie.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def series_params
      params.require(:series).permit(:name, :value, :currency)
    end


end
