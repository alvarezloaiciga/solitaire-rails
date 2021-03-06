Solitaire::Application.routes.draw do
  get 'solitaire/new', to: 'solitaire#new'
  post 'solitaire', to: 'solitaire#create'

  post 'solitaire/:id/move_card', to: 'solitaire#move_card', as: :move_card
  post 'solitaire/:id/next_card', to: 'solitaire#next_card', as: :next_card
  get 'solitaire/:id', to: 'solitaire#show', as: :game_show
end
