class GreetingsController < ApplicationController
  def hello
    name = params[:name] || "John Doe"
    render json: { message: "Hello #{name}" }
  end
end
