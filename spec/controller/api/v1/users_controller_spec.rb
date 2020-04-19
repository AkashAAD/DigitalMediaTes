require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do

  describe "Post #sign_up" do
    it "Sign up with valid data" do
      user = { user: {first_name: "FN_demo", last_name: "LN_demo", email: 'user@abc.com', password: 'password', password_confirmation: 'password'} }
      response = post(:sign_up, params: user)
      expect(JSON.parse(response.body)['message']).to eq("User registered successfully.")
    end

    it "Sign up with invalid data" do
      user = { user: {first_name: "FN_demo", last_name: "LN_demo", email: 'usercom', password: 'passwo', password_confirmation: 'password'} }
      response = post(:sign_up, params: user)
      expect(response.status).to eq(406)
    end
  end

  describe "Post #sign_in" do
    it "Sign in with valid data" do
      user = { user: {first_name: "FN_demo", last_name: "LN_demo", email: 'user@abc.com', password: 'password', password_confirmation: 'password'} }
      post(:sign_up, params: user)
      response = post(:sign_in, params: {user: {email: 'user@abc.com', password: 'password'}})
      expect(JSON.parse(response.body)['message']).to eq("You have logged in successfully.")
    end

    it "Sign in with invalid data" do
      user = { user: {first_name: "FN_demo", last_name: "LN_demo", email: 'user@abc.com', password: 'password', password_confirmation: 'password'} }
      post(:sign_up, params: user)
      response = post(:sign_in, params: {user: {email: 'user@abc.com', password: 'password1'}})
      expect(JSON.parse(response.body)['status']).to eq(401)
    end
  end  

end