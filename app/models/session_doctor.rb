class SessionDoctor < ApplicationRecord
  belongs_to :session
  belongs_to :doctor

  after_create :update_session_id

  def update_session_id
    return if session.ended_at?

    session.update(session_id: "#{session.session_id}-#{doctor_id}")
  end
end
