class HoursController < ApplicationController
  before_action :authenticate_user!
  before_action :set_hour, only: [:show, :edit, :update, :destroy]
  before_action :set_peginate, only: :index

  # GET /hours
  # GET /hours.json
  def index
    unless params[:date_from].blank? and params[:date_to].blank?
      @conditions = 'date BETWEEN (?) AND (?)', DateTime.parse(params[:date_from]), DateTime.parse(params[:date_to])
    end
    @user       = build_condition :user_id
    if current_user.admin?
      @hours      = current_company.hours.includes(:task,:project,:line).where(@conditions).page(@page).per(@per_page)
    else
      @hours      = current_user.hours.includes(:task,:project,:line).where(@conditions).page(@page).per(@per_page)
    end
    @vacation_day = Hour.get_remaning_vacation_hours(current_user, current_company)
  end

  # GET /hours/1
  # GET /hours/1.json
  def show
  end

  # GET /hours/new
  def new
    @hour = Hour.new
  end

  # GET /hours/1/edit
  def edit
  end

  # POST /hours
  # POST /hours.json
  def create
    @hour = current_user.hours.new(hour_params)

    respond_to do |format|
      if @hour.save
        format.html { redirect_to @hour, notice: 'Hour was successfully created.' }
        format.json { render :show, status: :created, location: @hour }
      else
        format.html { render :new }
        format.json { render json: @hour.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hours/1
  # PATCH/PUT /hours/1.json
  def update
    respond_to do |format|
      if @hour.update(hour_params)
        format.html { redirect_to @hour, notice: 'Hour was successfully updated.' }
        format.json { render :show, status: :ok, location: @hour }
      else
        format.html { render :edit }
        format.json { render json: @hour.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hours/1
  # DELETE /hours/1.json
  def destroy
    @hour.destroy
    respond_to do |format|
      format.html { redirect_to hours_url, notice: 'Hour was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hour
      @hour = Hour.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def hour_params
      params.require(:hour).permit( :description, :project_id, :task_id, :line_id,
                                    :date, :time_from, :time_to, :pay_type_id )
    end
end
