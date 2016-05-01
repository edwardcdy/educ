Rails.application.routes.draw do
    get 'div',      to:"div#list"
    post 'div/create',   to:"div#create"
    get 'div/show/:id',      to:"div#show"
    get 'div/delete/:id',    to:"div#delete"
    put 'div/update/:id',  to:"div#update"
    get 'div/random',    to:"div#random"
end

