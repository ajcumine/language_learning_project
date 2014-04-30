class ConversationsController < ApplicationController

  def index
    @conversations = Conversation.all
    @message = Message.new
  end

  def new
    @conversation = Conversation.create
    @person_i_talk_to = User.find params[:user_id]

    @conversation.participants << Participant.new(user: current_user)
    @conversation.participants << Participant.new(user: @person_i_talk_to)
    @message = Message.new
  end

  def create
    @message = Message.new
    @conversation = Conversation.new params[:conversation].permit(:subject)
    @conversation.participants << Participant.new(:user => current_user, :conversation => @conversation)
    @conversation.save
    redirect_to @conversation
  end

  def edit
  end

  def show
    @conversation = Conversation.find params[:id]
    @message = Message.new(:conversation_id => @conversation)
  end

  def update
    @message = Message.new
    @conversation = Conversation.new params[:conversation].permit(:subject)
    @conversation.participants << Participant.new(:user => current_user, :conversation => @conversation)
    @conversation.save
    redirect_to @conversation
  end

  def destroy
    @conversation = Conversation.find params[:id]
    if @conversation.destroy
      flash[:notice] = "Message deleted"
      redirect_to '/conversations/'
    else
      flash[:notice] = "There was an error while deleting that message"
    end
  end
end
