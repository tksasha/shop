class ConfirmationMailer < ApplicationMailer
  def email user
    @token = user.confirmation_token

    mail subject: 'Confirmation', to: user.email
  end
end
