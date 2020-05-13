class ViewsController < ApplicationController
  before_action :authenticate_user!, exept:[:index]
  def index
    @view = View.all
  end

  def show
    @view = View.find(params[:id])
  end

  def new
    @view = View.new
  end

  def create
    @view=View.new(view_params)
    @view.user_id = current_user.id
    if @view.save
    redirect_to view_path(@view),notice:'SUCCESS'
    else
    render :new
    end
  end

  def edit
     @view = View.find(params[:id])
     if @view.user != current_user
      redirect_to views_path, alert:"Unauthorized access to email was detected."
  end
end
  def update
    @view = View.find(params[:id])
    if @view.update(view_params)
    redirect_to view_path(@view),notice:'SUCCESS'
    else
      render :edit
  end
end
  def destroy
    view = View.find(params[:id])
    view.destroy
    redirect_to views_path
  end

  private
  def view_params
    params.require(:view).permit(:title,:body,:image)
  end
end