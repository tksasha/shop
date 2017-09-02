module ActsAsAuthorizedController
  extend ActiveSupport::Concern

  included do
    include Pundit

    rescue_from Pundit::NotAuthorizedError do
      respond_to do |format|
        format.html { render 'errors/forbidden', status: :forbidden }

        format.json { head :forbidden }

        format.js { head :forbidden }

        format.pdf { head :forbidden }
      end
    end

    before_action -> { authorize resource }, except: :index

    before_action -> { authorize collection }, only: :index
  end
end
