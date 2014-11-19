class ProjectsController < ApplicationController

def new
  @project = Project.new
end

def create
  @project = Project.create(project_params)
  if @project.save
    flash[:success] = "Your new project has been saved!"
    redirect_to user_project_path(1, @project.id)
  end
end

def show
  @project = Project.find(params[:id])
end

def edit
  @project = Project.find(params[:id])
end

def update
  @project = Project.find(params[:id])
  @project.update_attributes(project_params)
  if @project.save
    flash[:success] = "Your project has been saved"
    redirect_to user_project_path(1, @project.id)
  else
    render :show
  end
end

private
  def project_params
    params.require(:project).permit(:name, :description)
  end

end