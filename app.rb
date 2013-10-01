require 'sinatra'
require 'compass'
require 'mongo'
require_relative "models/mailer"

class TwistedTech < Sinatra::Application

  include Mongo

  configure do
    Compass.configuration do |config|
      config.project_path = File.dirname __FILE__
      config.sass_dir = File.join "views", "stylesheets"
      config.images_dir = File.join "views", "images"
      config.http_path = "/"
      config.http_images_path = "/images"
      config.http_stylesheets_path = "/stylesheets"
    end

    set :scss, Compass.sass_engine_options
  end

  get '/stylesheets/:name.css' do
    content_type 'text/css', :charset => 'utf-8'
    scss :"stylesheets/#{params[:name]}"
  end

  get '/' do
      erb :index
  end

  post '/' do
    name = params[:name]
    email = params[:email]
    description = params[:description]

    Mailer.send_to_twisted_tech(name, email, description)
    Mailer.send_to_registrant(name, email, description)

    mongo_uri = ENV['MONGOLAB_URI']
    db_name = mongo_uri[%r{/([^/\?]+)(\?|$)}, 1]
    client = MongoClient.from_uri(mongo_uri)
    db = client.db(db_name)
    registrants = db.collection('registrants')
    current_time = Time.now
    registrants.insert({ name: name, email: email, description: description, signup_type: 'speaker', signup_date: current_time })

    redirect '/'
  end

end