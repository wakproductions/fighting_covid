class SurveyProviderRequestsController < ApplicationController

  def create
    SurveyResponse.find_or_create_by(
      form_type: 'provider_request',
      name: survey_params['name'],
      email: survey_params['email'],
      message: survey_params['message'],
    )
  end

  def new
  end

  private

  # Not using strong params right now
  def survey_params
    params.permit(
      :name,
      :email,
      :message,
      )
  end
end