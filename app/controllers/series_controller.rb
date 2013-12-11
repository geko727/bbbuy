class SeriesController < ApplicationController
  before_action :set_series, only: [:show, :edit, :update, :destroy]
  before_filter :require_user, only: [:show, :edit, :update, :destroy, :index, :new]
  #comment
  # GET /series
  # GET /series.json
  def index
    @series = Serie.find(:all,:order => 'id ASC')
  end

  def lv
  end


  def emailindex
    @emails = Email.find(:all,:order => 'id ASC')
    respond_to do |format|
      format.html
      format.csv { send_data Email.to_csv}
      format.xls # { send_data @products.to_csv(col_sep: "\t") }
    end
  end

  def validate_token
    @serie = Serie.where(token: params[:id])
    if @serie == []
      redirect_to "/lv"
    else
      redirect_to emailpage_path(token: params[:id])
    end
  end

  def set_coupon(email, serie)
    mail = Email.find_by_email(email)
    @cup =  serie.coupons.order("created_at asc").find_by(sent: nil) 
    if @cup 
      @cup.touch(:sent)
      @cup.update_column(:recipient, email)
      @cup.update_column(:email_id, mail.id)
      @available = @cup.serie.coupons.where(sent: nil).count 
      if @available == 0 
        @cup.serie.active = false
        @cup.serie.save
      end
      AppMailer.send_coupon_email(email, @cup, serie).deliver
    else
      AppMailer.send_coupon_email(email, @cup, serie).deliver
    end

  end


  def emailpage
    @active = Serie.all
    @series = Serie.where(token: params[:token])
    if @series == []
      redirect_to "/lv"
    end
  end

  def email
    #@ip = request.remote_ip
    #@ip2 = request.ip
    @coup = Serie.find_by_name(params[:series][:name])
    @email = params[:email][:email]
    #@full_name = params[:full_name][:full_name]
    valid_email = @email.match(/\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/);
    #valid_name = @full_name.match(/[\w]+([\s]+[\w]+){1}+/);
    @confirmation = params[:emailconf][:emailconf]
    if @email.split != @confirmation.split
      flash[:danger] = "Las direcciones de correo no concuerdan."
      redirect_to emailpage_path(token: @coup.token)
    else
      if valid_email #&& valid_name
        @c = @coup.coupons.where(recipient: params[:email][:email])
        #@n = Coupon.where(full_name: params[:full_name][:full_name])
        if @c != [] 
          flash[:danger] = "Esta dirección de correo ya ha sido utilizada para esta serie."
          redirect_to emailpage_path(token: @coup.token)
        #elsif @n != []
         # flash[:danger] = "This full name has already been used"
          #redirect_to email_path
        elsif @c == [] 
          @e = Email.find_by_email(@email)
          if @e != nil
            @email = @e.email
            set_coupon(@email, @coup)
          else
            Email.create(email: @email)
            set_coupon(@email, @coup)
          end
          #AppMailer.send_coupon_email().deliver
        end
      else
        flash[:danger] = "La dirección de correo no es valida. Debes ingresar un email valido."
        redirect_to emailpage_path(token: @coup.token)
      end
    end
  end

  # GET /series/1
  # GET /series/1.json
  def show
    respond_to do |format|
      format.html
      format.csv { send_data @series.coupons.to_csv}
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
    @coupon = Coupon.find_by_token(params[:token])
    redirect_to root_path unless @coupon 
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
    @seriesname = Serie.where(name: @series.name)
    if @seriesname != []
      flash[:danger] = "This series name is already in use"
      render new_series_path
      return
    end
    @allcoup = params[:allcoupons][:allcoupons]
    if @allcoup == ""
      flash[:danger] = "You must put at least a coupon"
      render new_series_path
      return
    else
      respond_to do |format|
      if @series.save
        @new = @allcoup.split(/\n/)
        y = []
        @new.uniq.each do |x|
          x = x.gsub(/\r/," ")
          x = x.gsub(/\n/," ")
          y << x.strip
        end
        y.uniq.each do |y|
          validate_coupon = y.match(/[\w]{1}+/);
          if validate_coupon  
            Coupon.create :serial => y, :serie_id => @series.id 
          end
        end
        flash[:success] = 'Serie was successfully created.'
        format.html { redirect_to @series}
        format.json { render action: 'show', status: :created, location: @series }
      else
        format.html { render action: 'new' }
        format.json { render json: @series.errors, status: :unprocessable_entity }
      end
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
