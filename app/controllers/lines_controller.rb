class LinesController < ApplicationController
  before_action :set_line, only: [:show, :edit, :update, :destroy]

  # GET /lines
  # GET /lines.json
  def index
    @lines = Line.all
  end

  # GET /lines/1
  # GET /lines/1.json
  def show
  end

  # GET /lines/new
  def new
    @tasks = Task.all
    @customers = Customer.all
    @projects = Project.all

    @line = Line.new
    @line.items.build
    @line.hours.build
    @line.travels.build
    @line.requisitions.build
  end

  # GET /lines/1/edit
  def edit
    @tasks = Task.all
  end

  # POST /lines
  # POST /lines.json
  def create
    @line = Line.new(line_params)
    respond_to do |format|
      if @line.save
        if params[:item].present?
          params[:item][params[:item].keys[0].to_sym].each_with_index do |item,index|
            item = Item.new(:reference_number=>params[:item][:reference_number][index], :amount=>params[:item][:amount][index], :pce=>params[:item][:pce][index],:user_id=>params[:line][:user_id], :project_id=>params[:line][:project_id], :task_id=>params[:line][:task_id],line_id: @line.try(:id))
            item.save
          end
        end
        if params[:hour].present?
          params[:hour][params[:hour].keys[0].to_sym].each_with_index do |hour,index|
            hour = Hour.new(:hours=>params[:hour][:hours][index], :time_from=>params[:hour][:time_from][index], :time_to=>params[:hour][:time_to][index], :amount=>params[:hour][:amount][index], :paytype=>params[:hour][:paytype][index], :description => params[:hour][:description][index],:user_id=>params[:line][:user_id], :project_id=>params[:line][:project_id], :task_id=>params[:line][:task_id],line_id: @line.try(:id))
            hour.save
          end
        end
        if params[:travel].present?
          params[:travel][params[:travel].keys[0].to_sym].each_with_index do |travel,index|
            travel = Travel.new(:date=>params[:travel][:date][index], :location_from=>params[:travel][:location_from][index], :destination_to=>params[:travel][:destination_to][index], :amount=>params[:travel][:amount][index],:user_id=>params[:line][:user_id], :project_id=>params[:line][:project_id], :task_id=>params[:line][:task_id],line_id: @line.try(:id))
            travel.save
          end
        end
        if params[:requisition].present?
          params[:requisition][params[:requisition].keys[0].to_sym].each_with_index do |requisition,index|
            requisition = Requisition.new(:reference_number=>params[:requisition][:reference_number][index], :pce=>params[:requisition][:pce][index], :amount=>params[:requisition][:amount][index],:user_id=>params[:line][:user_id], :project_id=>params[:line][:project_id], :task_id=>params[:line][:task_id],line_id: @line.try(:id))
            requisition.save
          end
        end
        format.html { redirect_to new_line_path, notice: 'Line was successfully created.' }
        format.json { render :show, status: :created, location: @line }
      else
        @customers = Customer.all
        @projects = Project.all
        @tasks = Task.all
        format.html { render :new }
        format.json { render json: @line.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lines/1
  # PATCH/PUT /lines/1.json
  def update
    respond_to do |format|
      if @line.update(line_params)
        format.html { redirect_to @line, notice: 'Line was successfully updated.' }
        format.json { render :show, status: :ok, location: @line }
      else
        format.html { render :edit }
        format.json { render json: @line.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lines/1
  # DELETE /lines/1.json
  def destroy
    @line.destroy
    respond_to do |format|
      format.html { redirect_to lines_url, notice: 'Line was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def set_controller
    @customers = Customer.all
    @projects = Project.all
    @tasks = Task.all
    @line = Line.new
    @line.items.build
    # @line.hours.build
    # @line.travels.build
    # @line.requisitions.build
     data = params.to_json
     respond_to do |format|
       format.json { render :json => data }
     end

  end
  def new_form
  end
  def change_form
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line
      @line = Line.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def line_params
      params.require(:line).permit(:user_id, :name, :customer_id, :project_id, :task_id, items_attributes: [:id, :name, :reference_number, :amount, :pce,:user_id, :project_id, :task_id, :_destroy], hours_attributes: [:id, :hours, :time_from, :time_to, :amount, :paytype, :description,:user_id, :project_id, :task_id, :_destroy], travels_attributes: [:id, :date, :location_from, :destination_to, :amount,:user_id, :project_id, :task_id , :_destroy] , requisitions_attributes: [:id, :reference_number, :pce, :amount,:user_id, :project_id, :task_id , :_destroy])
    end
end
