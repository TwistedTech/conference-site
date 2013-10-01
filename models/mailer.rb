require 'mail'
require 'postmark'

class Mailer
  def self.send_to_twisted_tech(name, email, description)
    message = Mail.new do
      from            'register@twisted-tech.com'
      to              'register@twisted-tech.com'
      subject         "My name is #{name}, and I'd like to speak at the conference"

      text_part do
        body "#{name} - #{email} - #{description}"
      end

      html_part do
        content_type 'text/html; charset=UTF-8'
        body "<h3>#{name}</h3><p>#{email}</p><p>#{description}</p>"
      end

      delivery_method Mail::Postmark, :api_key => ENV['POSTMARK_API_KEY']
    end

    message.deliver
  end

  def self.send_to_registrant(name, email, description)
    message = Mail.new do
      from            'register@twisted-tech.com'
      to              email
      subject         'Thanks for registering!'

      text_part do
        body "Hi #{name},\n Thanks for putting your name in the ring to speak at the Twisted Tech Conference in Austin on February 21, 2014. We will be in touch with you soon!"
      end

      html_part do
        content_type 'text/html; charset=UTF-8'
        body "<h3>Hi #{name}</h3><p>Thanks for putting your name in the ring to speak at the Twisted Tech Conference in Austin on February 21, 2014. We will be in touch with you soon!</p>"
      end

      delivery_method Mail::Postmark, :api_key => ENV['POSTMARK_API_KEY']
    end

    message.deliver
  end
end