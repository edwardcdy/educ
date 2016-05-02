Rails.application.routes.draw do
    get 'div',      to:"div#list"
    post 'div/create',   to:"div#create"
    get 'div/show/:id',      to:"div#show"
    get 'div/delete/:id',    to:"div#delete"
    put 'div/update/:id',  to:"div#update"
    get 'div/random',    to:"div#random"
    get 'popup',      to:"popup#list"
    post 'popup/create',   to:"popup#create"
    get 'popup/show/:id',      to:"popup#show"
    get 'popup/delete/:id',    to:"popup#delete"
    put 'popup/update/:id',  to:"popup#update"
    get 'popup/random',    to:"popup#random"
end

