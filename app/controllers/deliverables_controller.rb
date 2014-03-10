class DeliverablesController < ApplicationController
  def add_hour
    deliverable = Deliverable.find(params[:id])
    deliverable.hours.create()
    redirect_to :back
  end

  def remove_hour
    deliverable = Deliverable.find(params[:id])
    hour = deliverable.hours.where(:invoiced => false).pop
    hour.destroy if hour
    redirect_to :back
  end

  def complete
    deliverable = Deliverable.find(params[:id])

    deliverable.completed = !deliverable.completed
    deliverable.save
    redirect_to :back
  end

  def create
    @project = Project.find(params[:project_id])
    @deliverable = @project.deliverables.build(deliverable_params)

    if @deliverable.save
      redirect_to :back
    else
      flash.now[:errors] = @deliverable.errors.full_messages
      redirect_to :back
    end
  end

  def destroy
    @deliverable = Deliverable.find(params[:id])
    @deliverable.destroy
    redirect_to :back
  end

  def show
    @deliverable = Deliverable.find(params[:id])
    @project = @deliverable.project
    @notes = @deliverable.notes
    render :show
  end

  def edit
    @deliverable = Deliverable.find(params[:id])
    render :edit
  end

  def update
    @deliverable = Deliverable.find(params[:id])

    if @deliverable.update_attributes(deliverable_params)
      redirect_to deliverable_url(@deliverable)
    else
      flash.now[:errors] = @deliverable.errors.full_messages
      render :edit
    end
  end

  private

    def deliverable_params
      params.require(:deliverable).permit(:name, :parent_deliverable_id, :due_date, :hourly)
    end
end
