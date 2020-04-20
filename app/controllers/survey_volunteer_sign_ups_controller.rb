class SurveyVolunteerSignUpsController < ApplicationController

  def create
    SurveyResponse.find_or_create_by(
      form_type: 'volunteer_sign_up',
      name: survey_params['name'],
      email: survey_params['email'],
      message: survey_params['message'],
      form_questions: survey_params.to_h.slice('type_of_help')
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
      type_of_help: {},
    )
  end
end