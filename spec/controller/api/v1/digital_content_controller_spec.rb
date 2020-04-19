require 'rails_helper'

RSpec.describe Api::V1::DigitalContentController, type: :controller do

  describe "Post #login check" do
    it "Create movie with valid data and without login" do
      movie = { movie: { title: "Avangers - Infinity War", plot: "Iron Man, Thor, the Hulk and the rest of the Avengers unite to battle their most powerful enemy yet -- the evil Thanos. On a mission to collect all six Infinity Stones, Thanos plans to use the artifacts to inflict his twisted will on reality. The fate of the planet and existence itself has never been more uncertain as everything the Avengers have fought for has led up to this moment." } }
      response = post(:create_movie, params: movie)
      expect(response.status).to eq(401)
    end
  end

  describe "Post #create_movie" do
    it "Create movie with valid data" do
      # user = { user: {first_name: "FN_demo", last_name: "LN_demo", email: 'user@abc.com', password: 'password', password_confirmation: 'password', auth_token: 'dummy_token', role_id: 2 } }
      # User.create(user[:user])
      request.headers['Authorization'] = User.find_by(role_id: 1).auth_token

      movie = { movie: { title: "Avangers - Infinity War", plot: "Iron Man, Thor, the Hulk and the rest of the Avengers unite to battle their most powerful enemy yet -- the evil Thanos. On a mission to collect all six Infinity Stones, Thanos plans to use the artifacts to inflict his twisted will on reality. The fate of the planet and existence itself has never been more uncertain as everything the Avengers have fought for has led up to this moment." } }
      response = post(:create_movie, params: movie)
      expect(response.status).to eq(201)
    end

    it "Create movie with invalid data" do
      request.headers['Authorization'] = User.find_by(role_id: 1).auth_token
      movie = { movie: { title: "Avangers - Infinity War", plot: "Iron Man, Thor, the Hulk and the rest of the Avengers unite to battle their most powerful enemy yet -- the evil Thanos. On a mission to collect all six Infinity Stones, Thanos plans to use the artifacts to inflict his twisted will on reality. The fate of the planet and existence itself has never been more uncertain as everything the Avengers have fought for has led up to this moment." } }
      response = post(:create_movie, params: movie)
      response = post(:create_movie, params: movie)
      expect(response.status).to eq(406)
    end
  end

  describe "Post #create_season" do
    it "Create season with valid data" do
      request.headers['Authorization'] = User.find_by(role_id: 1).auth_token

      season = { season: { title: "Money Heist", plot: "A criminal mastermind who goes by The Professor has a plan to pull off the biggest heist in recorded history -- to print billions of euros in the Royal Mint of Spain. To help him carry out the ambitious plan, he recruits eight people with certain abilities and who have nothing to lose.", no_of_edposodes: 54 } }
      response = post(:create_season, params: season)
      expect(response.status).to eq(201)
    end

    it "Create season with invalid data" do
      request.headers['Authorization'] = User.find_by(role_id: 1).auth_token
      season = { season: { title: "Money Heist", plot: "A criminal mastermind who goes by The Professor has a plan to pull off the biggest heist in recorded history -- to print billions of euros in the Royal Mint of Spain. To help him carry out the ambitious plan, he recruits eight people with certain abilities and who have nothing to lose.", no_of_edposodes: 54 } }
      response = post(:create_season, params: season)
      response = post(:create_season, params: season)
      expect(response.status).to eq(406)
    end
  end

  describe "Post #create_episode" do
    it "Create episode with valid data" do
      request.headers['Authorization'] = User.find_by(role_id: 1).auth_token

      season = { season: { title: "Money Heist", plot: "A criminal mastermind who goes by The Professor has a plan to pull off the biggest heist in recorded history -- to print billions of euros in the Royal Mint of Spain. To help him carry out the ambitious plan, he recruits eight people with certain abilities and who have nothing to lose.", no_of_edposodes: 54 } }
      response = post(:create_season, params: season)
      episode = { episode: { title: "Bella ciao", plot: "One morning I awakened Oh Goodbye beautiful, Goodbye beautiful, Goodbye beautiful! Bye! Bye!", season_id: Season.first.id } }
      response = post(:create_episode, params: episode)
      expect(response.status).to eq(201)
    end

    it "Create episode with invalid data" do
      request.headers['Authorization'] = User.find_by(role_id: 1).auth_token

      episode = { episode: { title: "Bella ciao", plot: "One morning I awakened Oh Goodbye beautiful, Goodbye beautiful, Goodbye beautiful! Bye! Bye!" } }
      response = post(:create_episode, params: episode)
      response = post(:create_episode, params: episode)
      expect(response.status).to eq(406)
    end
  end

  describe "Post #create_option" do
    it "Create option with valid data" do
      request.headers['Authorization'] = User.find_by(role_id: 1).auth_token
      movie = { movie: { title: "Avangers - Infinity War", plot: "Iron Man, Thor, the Hulk and the rest of the Avengers unite to battle their most powerful enemy yet -- the evil Thanos. On a mission to collect all six Infinity Stones, Thanos plans to use the artifacts to inflict his twisted will on reality. The fate of the planet and existence itself has never been more uncertain as everything the Avengers have fought for has led up to this moment." } }
      response = post(:create_movie, params: movie)
      response = post(:create_option, params: {option: { video_quality: "HD", price: "20.30", type: "movie", movie_season_id: Movie.first.id }})
      expect(response.status).to eq(201)
    end

    it "Create option with duplicate data" do
      request.headers['Authorization'] = User.find_by(role_id: 1).auth_token
      movie = { movie: { title: "Avangers - Infinity War", plot: "Iron Man, Thor, the Hulk and the rest of the Avengers unite to battle their most powerful enemy yet -- the evil Thanos. On a mission to collect all six Infinity Stones, Thanos plans to use the artifacts to inflict his twisted will on reality. The fate of the planet and existence itself has never been more uncertain as everything the Avengers have fought for has led up to this moment." } }
      response = post(:create_movie, params: movie)
      response = post(:create_option, params: {option: { video_quality: "HD", price: "20.30", type: "movie", movie_season_id: Movie.first.id }})
      response = post(:create_option, params: {option: { video_quality: "HD", price: "20.30", type: "movie", movie_season_id: Movie.first.id }})      
      expect(response.status).to eq(406)
    end
  end  

end