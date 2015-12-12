class DevicesController < ApplicationController

  before_filter :set_resources

  def new
  	if params[:key] == @app.token
  	 @device = @app.devices.new(device_params)
  	 if @device.save
  	    render json: {success: 1}
  	  else
  	    render json: {error: 1, errors: @device.errors}
  	  end
  	else
  	 render json: {error: "La clé ne semble pas valide"}
  	end
  end

  def destroy
  end

  protected

  	def set_resources
  		@app = App.find(params[:app_id])
  		@device = Device.find(params[:id]) if params[:id]
  	end

  	def device_params
  		params.permit(:platform, :version, :uuid, :model, :token)
  	end
end
