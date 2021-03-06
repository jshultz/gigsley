class ConversationsController < ApplicationController
  before_filter :get_mailbox, :get_box, :get_user
  before_filter :check_current_subject_in_conversation, :only => [:show, :update, :destroy]

  def index
    if @box.eql? "inbox"
      @conversations = @mailbox.inbox
    elsif @box.eql? "sentbox"
      @conversations = @mailbox.sentbox
    else
      @conversations = @mailbox.trash
    end

    respond_to do |format|
      format.html { render @conversations if request.xhr? }
    end
  end

  def show
    if @box.eql? 'trash'
      @receipts = @mailbox.receipts_for(@conversation).trash
    else
      @receipts = @mailbox.receipts_for(@conversation).not_trash
    end
    render :action => :show
    @receipts.mark_as_read
  end

  def update
    if params[:untrash].present?
      @conversation.untrash(@user)
    end

    if params[:reply_all].present?
      last_receipt = @mailbox.receipts_for(@conversation).last
      @receipt = @user.reply_to_all(last_receipt, params[:body])
    end

    if @box.eql? 'trash'
      @receipts = @mailbox.receipts_for(@conversation).trash
    else
      @receipts = @mailbox.receipts_for(@conversation).not_trash
    end
    redirect_to :action => :show
    @receipts.mark_as_read

  end

  def destroy

    @conversation.move_to_trash(@user)

    respond_to do |format|
      format.html {
        if params[:location].present? and params[:location] == 'conversation'
          redirect_to conversations_path(:box => :trash)
        else
          redirect_to conversations_path(:box => @box, :page => params[:page])
        end
      }
      format.js {
        if params[:location].present? and params[:location] == 'conversation'
          render :js => "window.location = '#{conversations_path(:box => @box, :page => params[:page])}';"
        else
          render 'conversations/destroy'
        end
      }
    end
  end

  private

  def get_mailbox
    @mailbox = current_user.profile.mailbox
  end

  def get_user
    @user = current_user.profile
  end

  def get_box
    if params[:box].blank? or !["inbox", "sentbox", "trash"].include? params[:box]
      params[:box] = 'inbox'
    end

    @box = params[:box]
  end

  def check_current_subject_in_conversation
    @conversation = Mailboxer::Conversation.find_by_id(params[:id])

    if @conversation.nil? or !@conversation.is_participant?(@user)
      redirect_to conversations_path(:box => @box)
      return
    end
  end

end
