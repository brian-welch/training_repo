# # Preview all emails at http://localhost:3000/rails/mailers/user_mailer
# class UserMailerPreview < ActionMailer::Preview

#   # Preview this email at http://localhost:3000/rails/mailers/user_mailer/welcome
#   def welcome
#     UserMailer.welcome
#   end

# end

class UserMailerPreview < ActionMailer::Preview
  def welcome
    user = User.first
    UserMailer.welcome(user)
  end
end
