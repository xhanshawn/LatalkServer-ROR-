class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_action :set_session, only: [:show, :edit, :update, :destroy]

  # GET /sessions
  # GET /sessions.json
  def index
    @sessions = Session.all
  end

  # GET /sessions/1
  # GET /sessions/1.json
  def show
  end

  # GET /sessions/new
  def new
    @session = Session.new
  end

  # GET /sessions/1/edit
  def edit
  end

  # POST /sessions
  # POST /sessions.json
  def create
    @user = get_user

    if !@user.authenticate(params[:user][:password]) 
      render json: { notice: "wrong password", status: 'error'}, status: :unprocessable_entity 

    else
      
      @latest_session = @user.sessions.order("created_at DESC").first

      if @latest_session and @latest_session.logout_by == nil
        @latest_session.update_attribute(:logout_by, Time.now) 
      end

      @session = @user.sessions.new(session_params)
      @session.save
      render json: { notice: "successfully login", status: 'OK'}, status: :ok 
    end
   
      


    # @session = Session.new(session_params)

    # respond_to do |format|
    #   if @session.save
    #     format.html { redirect_to @session, notice: 'Session was successfully created.' }
    #     format.json { render :show, status: :created, location: @session }
    #   else
    #     format.html { render :new }
    #     format.json { render json: { notice: "No such user", status: 'error'}, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /sessions/1
  # PATCH/PUT /sessions/1.json
  def update
    @user = get_user
    @latest_session = @user.sessions.order("created_at DESC").first

    if @latest_session and @latest_session.logout_by == nil

      @params[:session][:logout_by] = Time.now
      @latest_session.update(session_params)
      # @latest_session.update_attribute(:logout_by, Time.now) 
      render json: { notice: "successfully logout", status: 'OK'}, status: :ok 
    else
      render json: { notice: "logout failed no session keep login for this user", status: 'error' }, status: :error 
    end



    # respond_to do |format|

    #   @params[:session][:logout_by] = Time.now

    #   if @session.update(session_params)
    #     format.html { redirect_to @session, notice: 'Session was successfully updated.' }
    #     format.json { render :show, status: :ok, location: @session }
    #   else
    #     format.html { render :edit }
    #     format.json { render json: @session.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # LOGOUT /users/logout.json

  def logout
    @user = get_user
    @latest_session = @user.sessions.order("created_at DESC").first

    if @latest_session and @latest_session.logout_by == nil

      # @params[:session][:logout_by] = Time.now
      # @latest_session.update(session_params)
      @latest_session.update_attribute(:logout_by, Time.now) 
      render json: { notice: "successfully logout", status: 'OK'}, status: :ok 
    else
      render json: { notice: "logout failed no session keep login for this user", status: 'error' }, status: :error 
    end

  end



  # DELETE /sessions/1
  # DELETE /sessions/1.json
  def destroy
    @session.destroy
    respond_to do |format|
      format.html { redirect_to sessions_url, notice: 'Session was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_session
      @session = Session.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def session_params
      # params[:session][:user_name] = params[:user][:name]
      # params[:session][:logout_by] = ''
      params.require(:session).permit(:user_name, :logout_by)
    end

    def get_user
      @user = User.find_by(name: params[:user][:name])
      
      if @user == nil
        render json: { notice: "No Such User", status: 'error'}, status: :unprocessable_entity 
      else 
        return @user
      end
    end
end
