Rails.application.routes.draw do
  root 'games#index'
  post 'set_names', to: 'games#set_names'
  post 'move', to: 'games#move'
  post 'end_turn', to: 'games#end_turn'

  post 'restart', to: 'games#restart'
  post 'reset', to: 'games#reset'
end