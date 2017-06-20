class MessagesController < ApplicationController

before_action :find_message , only: [:show ,:edit ,:update ,:destroy]
before_action :authenticate_user!, except: [ :index , :show]
  

  def index
    @message = Message.all.order("created_at DESC").paginate(page: params[:page], per_page: 3)
    #@message = Message.all.order("created_at DESC")
  end

  def new
    #@message = Message.new    #[one to many association]
    @message = current_user.messages.build
  end

  def show
  end

  def create
    #@message = Message.new(message_params)
    @message = current_user.messages.build(message_params)
    if @message.save
      redirect_to root_path
    else
      render 'new'
    end

  end


  def edit
  end

  def update #just like create 
    if @message.update(message_params)
      redirect_to message_path #show
    else
       render 'edit'
    end    
  end

  def destroy
     @message.destroy
     redirect_to root_path
    
  end

  private

  def message_params
    params.require(:message).permit(:title , :description)
  end 

  def find_message
    @message=Message.find(params[:id])
  end

end
