require 'sequel'

module RealTime
  DATABASE_URL = ENV['DATABASE_URL'] || 'sqlite:/'
  DB = Sequel.connect(DATABASE_URL)
end
