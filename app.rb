require 'sinatra'
require 'compass'

class TwistedTech < Sinatra::Application

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

  get '/contact' do
      erb :contact
  end

end