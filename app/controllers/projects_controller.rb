class ProjectsController < ApplicationController
  before_action :check_clients_list, only: :new

  def new
    if params[:client_id]
      @project = Project.new(client_id: params[:client_id])
    else
      @project = Project.new
    end
    render :new
  end

  def create
    @project = Project.new(project_params)
    @project.user_id = current_user.id
    @project.open = true

    if @project.save
      redirect_to project_url(@project)
    else
      flash.now[:errors] = @project.errors.full_messages
      render :new
    end
  end

  def destroy
    project = Project.find(params[:id])
    client = project.client
    project.destroy
    redirect_to client_url(client)
  end

  def show
    @project = Project.find(params[:id])
    @top_level_deliverables =
      @project.deliverables.where(:parent_deliverable_id => nil)
    render :show
  end

  def change_status
    @project = Project.find(params[:id])
    @project.open = !@project.open
    @project.save
    redirect_to :back
  end

  def edit
    @project = Project.find(params[:id])
    render :edit
  end

  def index
    @client = Client.find(params[:client_id])
    @projects = @client.projects
    render :index
  end

  def update
    @project = Project.find(params[:id])

    if @project.update_attributes(project_params)
      redirect_to project_url(@project)
    else
      flash[:errors] = @project.errors.full_messages
      render :edit
    end
  end

  def project_params
    params.require(:project).permit(:name, :description, :client_id)
  end

  def check_clients_list
    redirect_to new_client_url if current_user.clients.empty?
  end
end
