class CreateSurveyResponses < ActiveRecord::Migration[6.0]
  def change
    create_table :survey_responses do |t|
      t.string :form_type
      t.string :name
      t.string :email
      t.string :message
      t.jsonb :form_questions

      t.timestamps
    end
  end
end
