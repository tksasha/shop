class ConfirmationMailer < ApplicationMailer
  def email user
    @confirmation = Confirmation.new user

    mail subject: 'Confirmation', to: user.email
  end
end
