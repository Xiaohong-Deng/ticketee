class API::TicketsController < API::ApplicationController
  before_action :set_project

  def show
    @ticket = @project.tickets.find(params[:id])
    # if user logged in :authorize is called here
    # if not authorized it calls :not_authorized method
    authorize @ticket, :show?
    render json: @ticket
  end

  def create
    @ticket = @project.tickets.build(ticket_params)
    authorize @ticket, :create?
    if @ticket.save
      render json: @ticket, status: 201
    else
      render json: { errors: @ticket.errors.full_messages }, status: 422
    end
  end

  private
    def ticket_params
      params.require(:ticket).permit(:name, :description)
    end

    def set_project
      @project = Project.find(params[:project_id])
    end
end
