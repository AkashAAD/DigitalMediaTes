require 'rails_helper'

RSpec.describe Api::V1::LibraryController, type: :controller do

  describe "Post #login check" do
    it "Create library with valid data and without login" do
      movie = { movie: { title: "Avangers - Infinity War", plot: "Iron Man, Thor, the Hulk and the rest of the Avengers unite to battle their most powerful enemy yet -- the evil Thanos. On a mission to collect all six Infinity Stones, Thanos plans to use the artifacts to inflict his twisted will on reality. The fate of the planet and existence itself has never been more uncertain as everything the Avengers have fought for has led up to this moment." } }
      movie = Movie.create(movie[:movie])
      option = { option: { video_quality: "HD", price: "20.30" }}
      movie.options.create(option[:option])
      library = { library: { option_id: Option.first.id, type: "movie", movie_season_id: Movie.first.id }}
      response = post(:create_library, params: library)
      expect(response.status).to eq(401)
    end
  end

  describe "Post #create_library" do
    it "Create library with valid data" do
      user = { user: {first_name: "FN_demo", last_name: "LN_demo", email: 'user@abc.com', password: 'password', password_confirmation: 'password', auth_token: 'dummy_token', role_id: 2 } }
      User.create(user[:user])
      request.headers['Authorization'] = "dummy_token"
      movie = { movie: { title: "Avangers - Infinity War", plot: "Iron Man, Thor, the Hulk and the rest of the Avengers unite to battle their most powerful enemy yet -- the evil Thanos. On a mission to collect all six Infinity Stones, Thanos plans to use the artifacts to inflict his twisted will on reality. The fate of the planet and existence itself has never been more uncertain as everything the Avengers have fought for has led up to this moment." } }
      movie = Movie.create(movie[:movie])
      option = { option: { video_quality: "HD", price: "20.30" }}
      movie.options.create(option[:option])
      library = { library: { option_id: Option.first.id, type: "movie", movie_season_id: Movie.first.id }}
      response = post(:create_library, params: library)
      expect(response.status).to eq(201)
    end

    it "Create library with duplicate data" do
      user = { user: {first_name: "FN_demo", last_name: "LN_demo", email: 'user@abc.com', password: 'password', password_confirmation: 'password', auth_token: 'dummy_token', role_id: 2 } }
      User.create(user[:user])
      request.headers['Authorization'] = "dummy_token"
      movie = { movie: { title: "Avangers - Infinity War", plot: "Iron Man, Thor, the Hulk and the rest of the Avengers unite to battle their most powerful enemy yet -- the evil Thanos. On a mission to collect all six Infinity Stones, Thanos plans to use the artifacts to inflict his twisted will on reality. The fate of the planet and existence itself has never been more uncertain as everything the Avengers have fought for has led up to this moment." } }
      movie = Movie.create(movie[:movie])
      option = { option: { video_quality: "HD", price: "20.30" }}
      movie.options.create(option[:option])
      library = { library: { option_id: Option.first.id, type: "movie", movie_season_id: Movie.first.id }}
      response = post(:create_library, params: library)
      response = post(:create_library, params: library)
      expect(response.status).to eq(406)
    end
  end

end
