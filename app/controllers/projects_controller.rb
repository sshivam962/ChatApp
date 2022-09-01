class ProjectsController < ApplicationController
  before_action :admin_authorize
  before_action :set_project, only: %i[edit create show update destroy]
  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def edit
  end

  def show
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      redirect_to projects_path, notice: 'Project successfully created'
    else
      render :new
    end
  end

  def update
    if @project.update(project_params)
      redirect_to projects_path, notice: 'Project updated successfully'
    else
      render :edit
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_path, notice: 'Project deleted successfully'
  end

  private

  def project_params
    params.require(:project).permit(:project_name, articles_attributes: [:id, :title, :content, :_destroy])
  end

  def set_project
    @project = Project.find_by(id: params[:id])
  end
end
