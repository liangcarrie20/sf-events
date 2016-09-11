require 'rubygems'
require 'sinatra'
require 'sinatra/content_for'
require 'haml'
require 'sass'
require 'json'
require 'text'

# Compute Levenshtein distance between words (used in the autocomplete)
include Text::Levenshtein

#
# Configuration
#

configure do
  # Default Haml format is :xhtml
  set :haml, { :format => :html5 }
end

configure :development do
  require "sinatra/reloader"
end

configure :production do
  set :haml, { :ugly => true }
end

get "/search do
  erb :index
end

get "/countries" do
  content_type :json
  find_countries(params[:term]).to_json
end


private

# Country list from Rails country_select
COUNTRIES = ["0-5$","5-15$","15-25$",">25$"]

def find_countries(term)
  # Exact match
  countries = COUNTRIES.find{|c| c.downcase == term.downcase}.to_a

  # Partial match
  if countries.empty?
    countries = COUNTRIES.find_all{|c| c.downcase.include? term.downcase }

    # Here is where we call the distance method of the text gem. It computes the Levenshtein distance and
    # appends the results to the partial match done before
    max_distance = 5 # Should be tweaked
    countries += COUNTRIES.find_all{|c| distance(c, term) < max_distance}.sort_by{|c| distance(c, term) }

    countries.uniq!
  end

  countries
end
