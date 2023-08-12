Rails.application.routes.draw do
  get 'current_user', to: 'current_user#index'
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")

  #article routes
  root "articles#home"

  get "/details", to: "articles#details"

  get "/history", to: "articles#history"

  post "/create", to: "articles#create"

  patch "/update", to: "articles#update"

  delete "/delete", to: "articles#delete"

  get "/filter", to: "articles#filter"

  get "/search", to: "articles#search"

  get "/sort", to: "articles#sort"

  post "/like", to:"articles#like"

  get "/see_comments", to:"articles#comment_view"

  post "/comment", to:"articles#comment"

  get "/top_posts", to:"articles#top_posts"

  get "/topics", to:"articles#view_topics"

  get "/recommended", to:"articles#recommended_articles"

  get "/similar_authors", to:"articles#similar_authors"

  get "/save", to:"articles#save"



  #author routes

  get "/authors", to:"authors#home"

  get "/author", to: "authors#details"

  get "/profile", to: "authors#profile"

  patch "/profile_edit", to: "authors#profile_edit"

  get "/my_posts", to: "authors#my_posts"

  post "/follow", to: "authors#follow"

  get "/view_saved", to:"authors#view_saved"


  #draft routes

  get "/my_drafts", to:"drafts#my_drafts"

  get "/draft_history", to:"drafts#history"

  post "/create_draft", to:"drafts#create_draft"

  get "/draft_details", to:"drafts#draft_details"

  patch "/draft_update", to:"drafts#draft_update"

  post "/draft_post", to:"drafts#draft_post"

  delete "/draft_delete", to:"drafts#draft_delete"


  #list routes

  get "/my_lists", to:"lists#my_lists"

  post "/create_list", to:"lists#create_list"

  post "/insert_article", to:"lists#insert_article"

  post "/remove_article", to:"lists#remove_article"

  post "/share_list", to:"lists#share_list"

  post "/unshare_list", to:"lists#unshare_list"

  delete "/delete_list", to:"lists#delete_list"

  #payment route

  post "/pay", to:"payments#pay"

end
