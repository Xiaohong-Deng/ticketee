class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def index
    # show projects to those who are allowed to see them
    # according to Role table
    @projects = policy_scope(Project)
  end

  def show
    # Pundit will check if the current_user is allowed
    # to show @project, e.g. show.html.erb
    # it uses a ProjectPolicy class to check for permission
    authorize @project, :show?
    @tickets = @project.tickets
  end

  def edit
    # in ApplicationPolicy edit? simply calls update?
    # so both here are ok
    authorize @project, :update?
  end

  def update
    authorize @project, :update?
    if @project.update(project_params)
      flash[:notice] = "Project has been updated."
      redirect_to @project
    else
      flash[:alert] = "Project has not been updated."
      render "edit"
    end
  end

  private
    def project_params
      params.require(:project).permit(:name, :description)
    end

    def set_project
      @project = Project.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "The project you were looking for could not be found."
      redirect_to projects_path
    end
end
