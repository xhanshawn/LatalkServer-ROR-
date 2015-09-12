class MessagesController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  # GET /messages
  # GET /messages.json
  def index

    if params[:list] == "all"
      @messages = Message.all;
    else
      filter_message_by_params
    end

    if @messages == nil 
      
      render json: { error: "No such user; check the submitted email address",
      status: 400
      }, status: 400

    end
  end

  # GET /query
  # GET /query.json
  # def query
  #   filter_message_by_params
  #   if @messages == nil 
      
  #     render json: { error: "No such user; check the submitted email address",
  #     status: 400
  #     }, status: 400

  #   end
  # end


  # GET /messages/1
  # GET /messages/1.json
  def show
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json
  def create
    
    @user_name = params[:message][:user_name]
    @user = User.find_by(name: @user_name)

    if @user!=nil
      @message = @user.messages.new(message_params)
    else
      @message = Message.new(message_params)
    end

    respond_to do |format|
      if @message.save
        format.html { redirect_to @message, notice: 'Message was successfully created.' }
        format.json { render :show, status: :created, location: @message }
      else

        if @user==nil
          format.html { render :new , notice: 'not the user in the database.' }
        else
          format.html { render :new }
        end

        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end


  def like
    @message = Message.find(params[:id])
    l = @message[:like_num]
    @user = User.find_by(name: params[:message][:user_name])
    # User.find(self.user_id).comments.exists?(:message_id => self.message_id)
    repeat = @user.comments.exists?(:message_id => params[:id])

    if(not repeat)
      @message.update_attribute(:like_num, l + 1)
    end
    @comment = Comment.new({:like => true, :user_id => @user[:id], :message_id => @message[:id]})
    res = @comment.save
    respond_to do |format|
      if res
        format.html { redirect_to index, notice: 'Message was liked' }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  def dislike
    @message = Message.find(params[:id])
    l = @message[:dislike_num]
    @user = User.find_by(name: params[:message][:user_name])

    repeat = @user.comments.exists?(:message_id => params[:id])
    if(not repeat)
      @message.update_attribute(:dislike_num, l + 1)
    end
    @comment = Comment.new({:like => true, :user_id => @user[:id], :message_id => @message[:id]})
    res = @comment.save
    respond_to do |format|
      if res
        format.html { redirect_to index, notice: 'Message was liked' }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    

    respond_to do |format|
      if @message.update(message_params)
        if @old_user_name != @user_name
          format.html { redirect_to index, notice: 'Message was successfully updated.' }
        else
          format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        end
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:message_type, :content, :longitude, :latitude, :hold_time, :user_name, :image, :offset, :list, :start_id, :race_num, :like, :dislike)
    end

    def filter_message_by_params
      @messages = Message.all
      # if params[:action].eql? 'list' 
        @messages = Message.where(user_name: params[:user_name]) if params[:user_name]
        @messages = @messages.where(message_type: params[:message_type]) if params[:message_type]
        query_str = "hold_time = 0 OR hold_time + " + Time.now.to_i.to_s + " > created_at"
        # @messages = @messages.where(:created_at => (Time.now - :hold_time)..Time.now)
        @messages = @messages.where("hold_time = 0 OR hold_time > ? ", Time.now.to_i)
        longitude_upper = params[:longitude].to_f + params[:offset].to_f if params[:longitude] && params[:offset]
        longitude_lower = params[:longitude].to_f - params[:offset].to_f if params[:longitude] && params[:offset]
        latitude_upper = params[:latitude].to_f + (params[:offset].to_f)/2 if params[:latitude] && params[:offset]
        latitude_lower = params[:latitude].to_f - (params[:offset].to_f)/2 if params[:latitude] && params[:offset]

        @messages = @messages.where("longitude < ?", longitude_upper) if longitude_upper
        @messages = @messages.where("longitude > ?", longitude_lower) if longitude_lower
        @messages = @messages.where("latitude < ?", latitude_upper) if latitude_upper
        @messages = @messages.where("latitude > ?", latitude_lower) if latitude_lower
        

      # end

    end
end
