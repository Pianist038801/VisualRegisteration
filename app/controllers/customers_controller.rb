class CustomersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_customer, only: [:show, :edit, :update, :destroy]
  before_action :set_peginate, only: :index

  # GET /customers
  # GET /customers.json
  def index
    @name             = build_condition :name, 'name', 'like'
    @reference_number = build_condition :reference_number, 'reference_number', 'like'
    @customers        = current_company.customers.where(@conditions).page(@page).per(@per_page)
  end

  # GET /customers/1
  # GET /customers/1.json
  def show
  end

  # GET /customers/new
  def new
    @customer = Customer.new(:name => params[:name])
    render layout: false
  end

  # GET /customers/1/edit
  def edit
    render layout: false
  end

  # POST /customers
  # POST /customers.json
  def create
    @customer = current_company.customers.new(customer_params)

    respond_to do |format|
      if @customer.save
        format.html { redirect_to customers_url, notice: 'Customer was successfully created.' }
         format.js
        # format.json { render :show, status: :created, location: @customer }
      else
        format.html { render :new }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customers/1
  # PATCH/PUT /customers/1.json
  def update
    respond_to do |format|
      if @customer.update(customer_params)
        format.html { redirect_to customers_url, notice: 'Customer was successfully updated.' }
        format.json { render :show, status: :ok, location: @customer }
      else
        format.html { render :edit }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    @customer.destroy
    respond_to do |format|
      format.html { redirect_to customers_url, notice: 'Customer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = current_company.customers.find_by_id(params[:id])
      redirect_to dashboard_path, notice: "Sorry, Wrong action request!" if @customer.blank?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_params
      params.require(:customer).permit(:name, :reference_number)
    end
end
