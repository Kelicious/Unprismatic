class TopicsController < ApplicationController
  def new
    @forum = Forum.find(params[:forum_id])
    authenticate_privacy(@forum)

    @topic = @forum.topics.new
    @topic.posts.build
  end

  def create
    @topic = current_user.topics.new(params[:topic])
    @topic.forum_id = params[:forum_id]

    authenticate_privacy(@topic)

    if @topic.save
      redirect_to @topic
    else
      render :new
    end
  end

  def show
    @topic = Topic.find(params[:id])
    authenticate_privacy(@topic)
    @topic.register_view_by(current_user)
    @posts = @topic.posts.page params[:page]
  end

  def toggle_pinned
    @topic = Topic.find(params[:topic_id])
    authenticate_admin(@topic)
    @topic.toggle!(:pinned)
    flash[:notice] = @topic.pinned? ? "Pinned!" : "Unpinned!"
    redirect_back_or @topic
  end
end
