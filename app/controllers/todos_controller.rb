class TodosController < ApplicationController
	def index
		@todos = Todo.all
		respond_to do |format|
			format.html{}
			format.json{render json: @todos}
		end
	end

	def new
		@todo = Todo.new
	end

	def update
		@todo = Todo.find(params[:id])
		@todo.completed = params[:todo][:completed]
		if @todo.save
			render json: @todo
		end
	end

	def create
		# binding.pry
		@todo = Todo.new(todo_params)
		@todo.completed = false
		respond_to do |format|
			if @todo.save
				format.html{redirect_to todos_path}
				format.json{render json: @todo }
			else
				format.html{render :new}
				format.json{render json: @todo.errors, status: :unprocessable_entity}
			end
		end
	end

  def destroy
	  @todo = Todo.find(params[:id])
	  if @todo.destroy
	    render json: {}
	  else
	    render status: 400, nothing: true
	  end
	end

	private
	def todo_params
		params.require(:todo).permit(:description)
	end
end
