class AcceptsController < ApplicationController
  before_action :set_accept, only: [:show, :edit, :update, :destroy]
  before_action :logged_in

  def index
    @accepts = Accept.where(user_id: current_user.id)
    if @accepts.any?
      @terms_and_condition = TermsAndCondition.not_accepted_by(current_user.id).first
    else
      @terms_and_condition = TermsAndCondition.first
    end
  end

  def show
  end

  def new
    @accept = Accept.new
    @accept.terms_and_condition = TermsAndCondition.not_accepted_by(current_user.id).first
    redirect_to notes_path if @accept.terms_and_condition.blank?
  end

  def edit
  end

  def create
    @accept = Accept.new(accept_params)
    @accept.user_id = current_user.id
    @accept.save
    redirect_to new_accept_path
  end

  def update
    respond_to do |format|
      if @accept.update(accept_params)
        format.html { redirect_to @accept, notice: 'Accept was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @accept.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @accept.destroy
    respond_to do |format|
      format.html { redirect_to accepts_url }
      format.json { head :no_content }
    end
  end

  private
    def set_accept
      @accept = Accept.find(params[:id])
    end

    def accept_params
      params.require(:accept).permit(:terms_and_condition_id)
    end
end
