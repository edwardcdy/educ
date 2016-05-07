Rails.application.routes.draw do
    get 'api/div',      to:"div#list"
    post 'api/div/create',   to:"div#create"
    get 'api/div/show/:id',      to:"div#show"
    get 'api/div/delete/:id',    to:"div#delete"
    put 'api/div/update/:id',  to:"div#update"
    get 'api/div/random',    to:"div#random"
    post 'api/div/clear/', to:"div#delete_all"
    put 'api/div/increment/:id', to:"div#increment"
    get 'api/popup',      to:"popup#list"
    post 'api/popup/create',   to:"popup#create"
    get 'api/popup/show/:id',      to:"popup#show"
    get 'api/popup/delete/:id',    to:"popup#delete"
    put 'api/popup/update/:id',  to:"popup#update"
    get 'api/popup/random',    to:"popup#random"
    post 'api/popup/clear/', to:"popup#delete_all"
end

