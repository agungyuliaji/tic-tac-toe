require 'rails_helper'

RSpec.describe GameManager, type: :model do
  let(:session) { {} }
  subject(:game_manager) { GameManager.new(session) }

  describe '#initialize' do
    it 'sets up game defaults' do
      expect(game_manager.board).to eq(Array.new(9))
      expect(game_manager.current_player).to eq("X")
    end
  end

  describe '#set_player_names' do
    before { game_manager.set_player_names(player_1_name, player_2_name) }

    context 'when both names are provided' do
      let(:player_1_name) { 'Goku' }
      let(:player_2_name) { 'Vegeta' }

      it 'sets the names correctly' do
        expect(session[:player_1_name]).to eq('Goku')
        expect(session[:player_2_name]).to eq('Vegeta')
      end
    end

    context 'when names are not provided' do
      let(:player_1_name) { nil }
      let(:player_2_name) { nil }

      it 'defaults to Player 1 and Player 2' do
        expect(session[:player_1_name]).to eq('Player 1')
        expect(session[:player_2_name]).to eq('Player 2')
      end
    end
  end

  describe '#ready?' do
    context 'when both player names are filled' do
      before { game_manager.set_player_names('Goku', 'Vegeta') }

      it 'returns true' do
        expect(game_manager.ready?).to be true
      end
    end

    context 'when one or both player names are not filled' do
      it 'returns false' do
        expect(game_manager.ready?).to be false
      end
    end
  end

  describe '#check_combination' do
    before do
      game_manager.set_player_names('Goku', 'Vegeta')
      session[:board] = board
    end

    context 'when there is a winning combination for X' do
      let(:board) { ['X', 'X', 'X', nil, 'O', 'O', nil, nil, nil] }

      it 'sets winner to X' do
        game_manager.check_combination
        expect(game_manager.winner).to eq('X')
      end
    end

    context 'when there is a winning combination for O' do
      let(:board) { [nil, 'X', nil, 'O', 'O', 'O', nil, 'X', nil] }

      it 'sets winner to O' do
        game_manager.check_combination
        expect(game_manager.winner).to eq('O')
      end
    end

    context 'when there is a draw' do
      let(:board) { ['X', 'O', 'X', 'X', 'O', 'O', 'O', 'X', 'X'] }

      it 'sets winner to Draw' do
        game_manager.check_combination
        expect(game_manager.winner).to eq('Draw')
      end
    end
  end

  describe '#switch_player' do
    it 'switches the current player' do
      expect { game_manager.switch_player }.to change { game_manager.current_player }.from('X').to('O')
    end
  end

  describe '#restart' do
    before do
      game_manager.set_player_names('Goku', 'Vegeta')
      game_manager.restart
    end

    it 'resets the board and current player' do
      expect(session[:board]).to eq(Array.new(9))
      expect(game_manager.current_player).to eq("X")
    end
  end

  describe '#reset' do
    before do
      game_manager.set_player_names('Goku', 'Vegeta')
      game_manager.reset
    end

    it 'clears all game-related session data' do
      expect(session).to be_empty
    end
  end
end
