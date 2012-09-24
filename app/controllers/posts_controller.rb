class PostsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index, :posts_detail] 
  helper_method :sort_column, :sort_direction
  # GET /posts
  # GET /posts.json
  def index
		if params[:tag]
			@posts = Post.tagged_with(params[:tag]).order(sort_column + " " + sort_direction).paginate(:per_page => 10, :page => params[:page])
		else
    	@posts = Post.order(sort_column + " " + sort_direction).paginate(:per_page => 10, :page => params[:page])
		end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    if Post.find(params[:id]).user == current_user
      @post = Post.find(params[:id])    
    else
      redirect_to Post.find(params[:id]), notice: 'This is not your post, therefore you cannot edit'
    end
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = current_user.posts.new(params[:post])
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])
    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    if current_user.id == @post.user.id
      @post.destroy
    end
    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end
   
  def posts_detail
		if params[:tag]
			@posts = Post.tagged_with(params[:tag]).paginate(:per_page => 5, :page => params[:page], :order => 'created_at DESC')
		else
    	@posts = Post.paginate(:per_page => 5, :page => params[:page], :order => 'created_at DESC')
		end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end
  
  private 
  
  def sort_column
    Post.column_names.include?(params[:sort])? params[:sort] : "created_at"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction])? params[:direction] : "desc"
  end
  
end
