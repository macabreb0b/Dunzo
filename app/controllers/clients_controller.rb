class ClientsController < ApplicationController
  def new
    @client = Client.new
    render :new
  end

  def index
    @clients = current_user.clients
    render :index
  end

  def show
    @client = Client.find(params[:id])
    render :show
  end

  def create
    @client = Client.new(client_params)
    @client.user_id = current_user.id

    if @client.save
      redirect_to clients_url
    else
      flash[:errors] = @client.errors.full_messages
      render :new
    end
  end

  def destroy
    @client = Client.find(params[:id])
    @client.destroy
    redirect_to user_url(current_user)
  end

  private

    def client_params
      params.require(:client).permit(:email, :company, :name, :phone)
    end
end
