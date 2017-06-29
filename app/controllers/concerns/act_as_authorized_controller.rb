module ActAsAuthorizedController
  include Pundit

  extend ActiveSupport::Concern

  included do
    rescue_from Pundit::NotAuthorizedError do
      respond_to do |format|
        format.html { render 'errors/forbidden', status: :forbidden }

        format.json { head :forbidden }

        format.js { head :forbidden }
      end
    end

    before_action -> { authorize resource }, except: :index

    before_action -> { authorize collection }, only: :index
  end
end
