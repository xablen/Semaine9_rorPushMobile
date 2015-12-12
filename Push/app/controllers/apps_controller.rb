class AppsController < ApplicationController

  before_filter :set_app, except: [:index, :new, :create]
  authorize_resource

  def index
    @apps = App.where(user_id: current_user.id).page(params[:page])
  end

  def show
  end

  def edit
  end

  def update
    if @app.update(apps_params)
       redirect_to @app, success: "L'application #{@app.name} a bien été créée"
    else
       flash.now[:error] = "Certains champs n'ont pas été correctement remplis"
       render "edit"
    end
  end

  def new
    @app = App.new
  end

  def create
    @app = App.new(apps_params)
    @app.user_id = current_user.id
    if @app.save
      redirect_to @app, success: "L'application #{@app.name} a bien été créée"
    else
      flash.now[:error] = "Certains champs n'ont pas été correctement remplis"
      render "new"
    end
  end

  def destroy
  end

  protected

    def apps_params
      params.require(:app).permit(:name, :certificat_ios, :image)
    end

    def set_app
      @app = App.find(params[:id])
    end
end
