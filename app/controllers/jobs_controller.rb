class JobsController < ApplicationController
	before_action :find_job, only: [:show,:edit,:destroy,:update]

	def create
		@job = Job.new(jobs_params)

		if @job.save
			redirect_to @job
		else
			render "New"
		end
	end

	def destroy
		@job.destroy
		redirect_to root_path
	end

	def edit

	end

	def index
		if params[:category_id].blank?
			puts "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
			@jobs = Job.all.order("created_at DESC")
		else 
			puts "helooooooooooooooooooooooooooooooooooooooooooo"
			@category_id = Category.find_by(name: params[:category]).id
			@jobs = Job.where(category_id: @category_id).order("created_at DESC")
			puts @jobs
			puts "------------------------------------------------"
		end
	end

	def new
		@job = Job.new
	end

	def show

	end

	def update
		if @job.update(jobs_params)
			redirect_to @job
		else	
			render "Edit"
		end 
	end

	private

	def jobs_params
		params.require(:job).permit(:title, :description, :company, :url, :category_id)
	end

	def find_job
		@job = Job.find(params[:id])
	end
end
