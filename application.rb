require 'sinatra'
require 'action_mailer'

class Mailer < ActionMailer::Base
  default from: "Stock@Hegwin<notice@stock.hegwin.me>"

  def notify(email)
    mail to: email,
         subject: 'Notification From Stock@Hegwin',
         body: 'test'
  end
end

get '/' do
  'Yea!~'
end


configure do
  set :root,    File.dirname(__FILE__)
  set :views,   File.join(Sinatra::Application.root, 'views')
    
  # ActionMailer::Base.view_paths = File.join(Sinatra::Application.root, 'views')

  if production?
    ActionMailer::Base.smtp_settings = {
      :address => "smtp.sendgrid.net",
      :port => '25',
      :authentication => :plain,
      :user_name => ENV['SENDGRID_USERNAME'],
      :password => ENV['SENDGRID_PASSWORD'],
      :domain => ENV['SENDGRID_DOMAIN'],
    }
  else
    ActionMailer::Base.delivery_method = :file
    ActionMailer::Base.file_settings = { :location => File.join(Sinatra::Application.root, 'tmp/emails') }
  end
end
