# POST /posts
  def create
    @post = Post.new(post_params)
    if @post.save

      # 以下6行を追記
      if params[:post][:image]
        File.binwrite("public/post_images/#{@post.id}.jpg", params[:post][:image].read)
        @post.update(image_name: "#{@post.id}.jpg" )
      else
        @post.update(image_name: "default.jpg" )
      end

      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new
    end
  end


  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)

      # 以下4行を追記
      if params[:post][:image]
        File.binwrite("public/post_images/#{@post.id}.jpg", params[:post][:image].read)
        @post.update(image_name: "#{@post.id}.jpg" )
      end

      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end