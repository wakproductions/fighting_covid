class SurveyProviderRequestsController < ApplicationController

  def create

  end

  def new

  end

  private

  def survey_params
    params.require(:person).permit(:form_type, :name, :email, :message, :form_questions)
  end
end