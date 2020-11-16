class HomeController < ApplicationController
  def index
    render json: {message: 'Api V1'}
  end
end
