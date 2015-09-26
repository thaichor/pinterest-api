require 'spec_helper'

describe "Pinterest::Client::User" do

  before do
    @client = Pinterest::Client.new(ENV['ACCESS_TOKEN'])
  end

  describe 'GET /v1/me/' do
    it 'should get the user object' do
      VCR.use_cassette("v1_me") do
        response = @client.get('me/')
        expect(response.data.first_name).to eq('Adeel')
        expect(response.data.last_name).to eq('Ahmad')
        expect(response.data.keys).to match_array(['id', 'url', 'first_name', 'last_name'])
      end
    end
  end

  describe 'GET /v1/me/likes/' do
    it "should get the user's likes" do
      VCR.use_cassette("v1_me_likes") do
        response = @client.get('me/likes/')
        expect(response.data.class).to eq(Array)
        expect(response.data.first.keys).to match_array(['id', 'link', 'note', 'url'])
      end
    end
  end

  describe 'GET /v1/users/shopseen' do
    it "should fetch a single user" do
      VCR.use_cassette("v1_user") do
        response = @client.get('users/shopseen/')
        expect(response.data.first_name).to eq('Shopseen')
        expect(response.data.last_name).to eq('')
        expect(response.data.keys).to match_array(['id', 'url', 'first_name', 'last_name'])
      end
    end
  end

  describe 'GET /v1/me/search/pins' do
    it "should search the user's pins" do
      VCR.use_cassette("v1_me_search_pins") do
        response = @client.get('me/search/pins/', {query: 'misophonia'})
        expect(response.data.class).to eq(Array)
      end
    end
  end

  describe 'GET /v1/me/search/boards' do
    it "should search the user's boards" do
      VCR.use_cassette("v1_me_search_boards") do
        response = @client.get('me/search/boards/', {query: 'randumb'})
        expect(response.data.class).to eq(Array)
      end
    end
  end

  describe 'GET /v1/me/followers' do
    it "should get the user's followers" do
      VCR.use_cassette("v1_me_followers") do
        response = @client.get('me/followers/')
        expect(response.data.class).to eq(Array)
      end
    end
  end

  describe 'GET /v1/me/following/boards' do
    it "should get boards the user is following" do
      VCR.use_cassette("v1_me_following_boards") do
        response = @client.get('me/following/boards/')
        expect(response.data.class).to eq(Array)
      end
    end
  end

  describe 'GET /v1/me/following/users' do
    it "should get users the user is following" do
      VCR.use_cassette("v1_me_following_users") do
        response = @client.get('me/following/users/')
        expect(response.data.class).to eq(Array)
      end
    end
  end

  describe 'GET /v1/me/following/interests' do
    it "should get interests the user is following" do
      VCR.use_cassette("v1_me_following_interests") do
        response = @client.get('me/following/interests/')
        expect(response.data.class).to eq(Array)
      end
    end
  end

  describe 'POST /v1/me/following/users' do
    context "another user exists" do
      it "should follow the user" do
        VCR.use_cassette("v1_me_follow_existing_user") do
          response = @client.post('me/following/users/', {user: 'nordstrom'})
          expect(response).to have_key(:data)
          expect(response.data).to be_falsey
        end
      end
    end
    context "another user does not exist" do
      it "should respond with an error message" do
        VCR.use_cassette("v1_me_follow_non_existing_user") do
          response = @client.post('me/following/users/', {user: 'aw9urhgwlahugoahglwahg'})
          expect(response.message).to be
        end
      end
    end
  end

  describe 'DELETE /v1/me/following/users/<user_id>/' do
    context "another user exists" do
      it "should unfollow the user" do
        VCR.use_cassette("v1_me_unfollow_existing_user") do
          response = @client.delete('me/following/users/nordstrom/')
          expect(response).to have_key(:data)
          expect(response.data).to be_falsey
        end
      end
    end
    context "another user does not exist" do
      it "should respond with an error message" do
        VCR.use_cassette("v1_me_unfollow_non_existing_user") do
          response = @client.delete('me/following/users/aw9urhgwlahugoahglwahg/')
          expect(response.message).to be
        end
      end
    end
  end

  describe 'POST /v1/me/following/boards' do
    context "another board exists" do
      it "should follow the board" do
        VCR.use_cassette("v1_me_follow_existing_board") do
          response = @client.post('me/following/boards/', {board: '259308959733676461'})
          expect(response).to have_key(:data)
          expect(response.data).to be_falsey
        end
      end
    end
    context "another board does not exist" do
      it "should respond with an error message" do
        VCR.use_cassette("v1_me_follow_non_existing_board") do
          response = @client.post('me/following/boards/', {board: 'aw9urhgwlahugoahglwahg'})
          expect(response.message).to be
        end
      end
    end
  end

  describe 'DELETE /v1/me/following/boards/<board_id>/' do
    context "another board exists" do
      it "should unfollow the board" do
        VCR.use_cassette("v1_me_unfollow_existing_board") do
          response = @client.delete('me/following/boards/259308959733676461/')
          expect(response).to have_key(:data)
          expect(response.data).to be_falsey
        end
      end
    end
    context "another board does not exist" do
      it "should respond with an error message" do
        VCR.use_cassette("v1_me_unfollow_non_existing_board") do
          response = @client.delete('me/following/boards/aw9urhgwlahugoahglwahg/')
          expect(response.message).to be
        end
      end
    end
  end

  describe 'POST /v1/me/following/interests' do
    context "another interest exists" do
      it "should follow the interest" do
        VCR.use_cassette("v1_me_follow_existing_interest") do
          response = @client.post('me/following/interests/', {interest: '259308959733676461'})
          expect(response).to have_key(:data)
          expect(response.data).to be_falsey
        end
      end
    end
    context "another interest does not exist" do
      it "should respond with an error message" do
        VCR.use_cassette("v1_me_follow_non_existing_interest") do
          response = @client.post('me/following/interests/', {interest: 'aw9urhgwlahugoahglwahg'})
          expect(response.message).to be
        end
      end
    end
  end

  describe 'DELETE /v1/me/following/interests/<interest_id>/' do
    context "another interest exists" do
      it "should unfollow the interest" do
        VCR.use_cassette("v1_me_unfollow_existing_interest") do
          response = @client.delete('me/following/interests/259308959733676461/')
          expect(response).to have_key(:data)
          expect(response.data).to be_falsey
        end
      end
    end
    context "another interest does not exist" do
      it "should respond with an error message" do
        VCR.use_cassette("v1_me_unfollow_non_existing_interest") do
          response = @client.delete('me/following/interests/aw9urhgwlahugoahglwahg/')
          expect(response.message).to be
        end
      end
    end
  end


end
