require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  let(:dummy_session) { {} }

  describe "GET #index" do
    it "calls check_combination on the game manager" do
      gm = instance_double("GameManager")
      allow(GameManager).to receive(:new).and_return(gm)
      expect(gm).to receive(:check_combination)

      get :index, session: dummy_session
    end
  end

  describe "POST #set_names" do
    it "sets player names and redirects to root path" do
      post :set_names, params: { player_1_name: "Alice", player_2_name: "Bob" }, session: dummy_session

      expect(session[:player_1_name]).to eq("Alice")
      expect(session[:player_2_name]).to eq("Bob")
      expect(response).to redirect_to(root_path)
    end
  end

  describe "POST #move" do
    it "updates the board and redirects to root path" do
      session[:board] = Array.new(9)
      post :move, params: { index: 0 }, session: dummy_session

      expect(session[:board][0]).not_to be_nil
      expect(response).to redirect_to(root_path)
    end
  end

  describe "POST #restart" do
    it "restarts the game and redirects to root path" do
      post :restart, session: dummy_session
      puts session.inspect

      expect(session).not_to include(:winner)
      expect(session).to include(:board, :current_player)
      expect(response).to redirect_to(root_path)
    end
  end

  describe "POST #reset" do
    it "resets the game and redirects to root path" do
      post :reset, session: dummy_session

      expect(session).not_to include(:winner, :player_1_name, :player_2_name, :board, :current_player)
      expect(response).to redirect_to(root_path)
    end
  end
end
