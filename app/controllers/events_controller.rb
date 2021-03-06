class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:create,:update,:edit,:new]
  # GET /events
  # GET /events.json
  def index
    @events = Event.all
    
  end
  def my_events
    @user = current_user.id
    @events=Event.where(:user_id => @user).where(:published => "1")
  end
  # GET /events/1
  # GET /events/1.json
  def show
    #only show users events
    
  end

  def search
    @event=Event.new
    @search_result=Event.where(:venue => @event.venue).where(:title => @event.title)
  end

  def ticket_step1

    $title=params[:title]
    redirect_to '/event/search_result'

  end

  def search_result
    @events=Event.find(:all, :conditions=> ["title LIKE ?", $title])
  end
  # GET /events/new
  def new

        @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create

    @event = Event.new(event_params)
    @event.user_id=current_user.id
        respond_to do |format|
          if @event.save
            format.html { redirect_to @event, notice: 'Event was successfully created.' }
            format.json { render :show, status: :created, location: @event }
          else
            format.html { render :new }
            format.json { render json: @event.errors, status: :unprocessable_entity }
          end
        end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:title, :description, :venue, :genere, :event_date_time,:user_id )
    end
end
