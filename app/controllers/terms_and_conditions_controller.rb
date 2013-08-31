class TermsAndConditionsController < ApplicationController
  before_action :logged_in
  before_action :is_admin
  before_action :set_terms_and_condition, only: [:show, :edit, :update, :destroy]

  def index
    @terms_and_conditions = TermsAndCondition.all
  end

  def show
  end

  def new
    @terms_and_condition = TermsAndCondition.new
  end

  def edit
  end

  def create
    @terms_and_condition = TermsAndCondition.new(terms_and_condition_params)

    respond_to do |format|
      if @terms_and_condition.save
        format.html { redirect_to @terms_and_condition, notice: 'Terms and condition was successfully created.' }
        format.json { render action: 'show', status: :created, location: @terms_and_condition }
      else
        format.html { render action: 'new' }
        format.json { render json: @terms_and_condition.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @terms_and_condition.update(terms_and_condition_params)
        @terms_and_condition.accepts.each do |accept|
          accept.destroy
        end
        format.html { redirect_to @terms_and_condition, notice: 'Terms and condition was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @terms_and_condition.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @terms_and_condition.destroy
    respond_to do |format|
      format.html { redirect_to terms_and_conditions_url }
      format.json { head :no_content }
    end
  end

  def is_admin
    unless current_user.is_admin?
      redirect_to notes_path, notice: "Access to Terms and Conditions is only permitted for admins"
    end
  end

  private
  def set_terms_and_condition
    @terms_and_condition = TermsAndCondition.find(params[:id])
  end

  def terms_and_condition_params
    params.require(:terms_and_condition).permit(:title, :body)
  end

end
