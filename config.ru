require './app/controllers/application_controller'
require './app/controllers/tweets_controller.rb'
require './app/controllers/users_controller.rb'

use TweetsController
use UsersController
run ApplicationController