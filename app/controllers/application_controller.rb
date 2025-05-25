require 'pagy/extras/bootstrap' 

class ApplicationController < ActionController::Base
  include Pagy::Backend
end
