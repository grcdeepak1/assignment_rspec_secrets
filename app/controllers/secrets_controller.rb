class SecretsController < ApplicationController
  before_action :set_secret, only: [:edit, :update, :destroy]
  skip_before_action :require_login, :only => [:index, :show]

  # GET /secrets
  # GET /secrets.json
  def index
    @secrets = Secret.last_five
  end

  # GET /secrets/1
  # GET /secrets/1.json
  def show
    @secret = Secret.find(params[:id])
  end

  # GET /secrets/new
  def new
    @secret = Secret.new
  end

  # GET /secrets/1/edit
  def edit
    @secret = Secret.find(params[:id])
  end

  # POST /secrets
  # POST /secrets.json
  def create
    @secret = current_user.secrets.build(secret_params)

    respond_to do |format|
      if @secret.save
        format.html { redirect_to @secret, notice: 'Secret was successfully created.' }
        format.json { render :show, status: :created, location: @secret }
      else
        format.html { render :new }
        format.json { render json: @secret.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /secrets/1
  # PATCH/PUT /secrets/1.json
  def update
    respond_to do |format|
      if @secret.update(secret_params)
        format.html { redirect_to @secret, notice: 'Secret was successfully updated.' }
        format.json { render :show, status: :ok, location: @secret }
      else
        format.html { render :edit }
        format.json { render json: @secret.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /secrets/1
  # DELETE /secrets/1.json
  def destroy
    @secret.destroy
    respond_to do |format|
      format.html { redirect_to secrets_url, notice: 'Secret was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # In this case, we will (intentionally) get an error if
    #   the secret you're trying to access doesn't belong to you
    # In real world scenarios, we'd be more likely to set a
    #   flash message and redirect with a proper error code here
    def set_secret
      @secret = current_user.secrets.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def secret_params
      params.require(:secret).permit(:title, :body)
    end
end
