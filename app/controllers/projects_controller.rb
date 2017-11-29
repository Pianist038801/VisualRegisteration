class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  # GET /projects
  # GET /projects.json
  def index
    @customer         = build_condition :customer_id, 'customer_id', '='
    @reference_number = build_condition :reference_number, 'reference_number', 'like'
    @projects         = current_company.projects.includes(:customer).where(@conditions).page(@page).per(@per_page)
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = current_company.projects.new(:name => params[:name])
    render layout: false
  end

  # GET /projects/1/edit
  def edit
    render layout: false
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = current_company.projects.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to projects_url, notice: 'Project was successfully created.' }
        format.js 
        # format.json { render :show, status: :created, location: @project }
      else
        puts @project.errors.full_messages
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to projects_url, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = current_company.projects.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name, :reference_number, :customer_id, :billable, :active, :planned_hours)
    end
end
