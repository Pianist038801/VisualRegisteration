class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  # GET /tasks
  # GET /tasks.json
  def index
    @project = build_condition :project_id, 'project_id', '='
    @name    = build_condition :name, 'tasks.name', 'like'
    @tasks   = current_company.tasks.includes(:project).where(@conditions).page(@page).per(@per_page)
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new(:name => params[:name])
    render layout: false
  end

  # GET /tasks/1/edit
  def edit
    render layout: false
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to tasks_url, notice: 'Task was successfully created.' }
        format.js 
        # format.json { render :show, status: :created, location: @task }
      else
        format.html { redirect_to tasks_url, notice: 'Please fill correct data.' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to tasks_url, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { redirect_to tasks_url, notice: 'Please fill correct data.' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def filter
    data = []

    project = Project.find_by_id(params[:project_id])
    if project && current_company.customers.pluck(:id).include?(project.customer_id)
      build_condition :project_id
      data  = current_company.tasks.where(@conditions).pluck(:id, :name)
    end
    data = data.map { |t| { id: t[0], name: t[1] }}
    data = data.unshift({ id: nil, name: 'Select Task' })

    render json: data
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = current_company.tasks.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:name, :project_id)
    end
end
