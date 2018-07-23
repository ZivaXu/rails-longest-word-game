require 'json'
require 'open-uri'

class GamesController < ApplicationController
  LETTERS = [*('A'..'Z')].sample(10)

  def new
    @grid = LETTERS
  end

  def score
    @grid = LETTERS
    @grid_m = @grid
    @answer = params[:answer]
    user_content = JSON.parse(open("https://wagon-dictionary.herokuapp.com/#{@answer}").read)
    contains = @answer.upcase.split("").all? { |letter| @grid_m.delete(letter) }
    if !contains
      @message = "Sorry but #{@answer} can't be built out of #{@grid.join(', ')}"
    elsif !user_content['found']
      @message = "Sorry but #{@answer} does not seem to be a valid English word..."
    else
      @message = "Congratulations! #{@answer} is a valid English word!"
    end
  end
end

