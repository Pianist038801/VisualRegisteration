class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :set_peginate, only: :index

  def index
    @name  = build_condition :name, 'name', 'like'
    @email = build_condition :email, 'email', 'like'
    @users = current_company.users.where(@conditions).page(@page).per(@per_page)
  end

  def show
  end

  def new
    @user = current_company.users.new(:name => params[:name])
  end

  def edit
  end

  def create
    @user = current_company.users.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to users_url, notice: "#User Was Successfully Created" }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_url, notice: "User Was Successfully Updated" }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: "User Was Successfully Destroy" }
      format.json { head :no_content }
    end
  end

  private

    def set_user
      @user = current_company.users.find(params[:id])
      redirect_to dashboard_path, notice: "Sorry, Wrong action request!" if @user.blank?
    end

    def user_params
      params.require(:user).permit!
    end
end
