class TasksController < ApplicationController
    before_action :set_task, only: %i[ show edit update destroy ]

    def index
        @tasks = Task.all 
    end

    def new
        @task = Task.new
    end

    def create
        @task = Task.new(task_params)
        if @task.save
          flash[:notice] = 'Task was successfully created.'
          redirect_to tasks_url
        else
          render :new
        end
    end

    def show
    end
    
    def edit
    end

    def update
        if @task.update(task_params)
          flash[:notice] = 'Task was successfully updated.'
          redirect_to @task
        else
          render :edit
        end
    end
    
    def destroy
        @task.destroy
        flash[:notice] = 'Task was successfully destroyed.'
        redirect_to tasks_url
    end

    private
    def set_task
        @task = Task.find(params[:id])
    end
    def task_params
        params.require(:task).permit(:title, :content)
    end
end
