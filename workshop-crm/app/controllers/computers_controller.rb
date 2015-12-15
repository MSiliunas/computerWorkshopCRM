class ComputersController < ApplicationController
  def create
    @client = Client.find(params[:client_id])
    @computer = @client.computers.create(computer_params)
    redirect_to client_path(@client)
  end

  private
    def computer_params
      params.require(:computer).permit(:serial, :specs)
    end
end
