require 'mongo'
require 'mongoid'

class Person
  include Mongoid::Document

  field :name, type: String
  field :email, type: String
  field :description, type: String
  field :signup_type, type: String, default: 'Speaker'
  field :signup_date, type: DateTime, default: ->{ Time.now }

end