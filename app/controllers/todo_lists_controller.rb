class TodoListsController < ApplicationController
  before_action :set_todo_list, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index]
  before_action :correct_user, only: [:edit, :update, :destroy]


  def index
    if user_signed_in?
      @todo_lists = TodoList.where(user_id: current_user.id)
    else
      render :new_user
    end
  end

  def show
  end

  def new
    @todo_list = TodoList.new.build
  end

  def edit
  end

  def create
    @todo_list = TodoList.new(todo_list_params)

      if @todo_list.save
        redirect_to @todo_list, notice: 'Todo list was successfully created.'
      else
        render :new
      end
  end

  def update
    if @todo_list.update(todo_list_params)
      redirect_to @todo_list, notice: 'Todo list was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @todo_list.destroy
    redirect_to root_url, notice: 'Todo list was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_todo_list
      @todo_list = TodoList.find(params[:id])
    end

    def correct_user
      @todo_list = current_user.todo_lists.find_by(id: params[:id])
      redirect_to todo_lists_path, notice: "Not Authorized" if @todo_list.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def todo_list_params
      params.require(:todo_list).permit(:title, :description)
    end
end
