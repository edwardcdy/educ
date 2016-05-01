class DivController < ApplicationController
    def list
        @divs = Div.all
        render json: @divs #if stale?(etag: @divs.all, last_modified: @divs.maximum(:updated_at))
    end
    
    def show
        @div = Div.find(params[:id])
        render json: @div #if stale?(@contact)
    end
    
    def create
        @div = Div.new(div_params)
        
        if @div.save
            render json: {:status => "Successfully created and saved object"}
        else
            render json: @div.errors, status: :unprocessable_entity
        end
    end
    
    def update
        @div = Div.find(params[:id])
        
        if @div.update(div_params)
            render json: {:status => "Successfully changed object"}
        else
            render json: @div.errors, status: :unprocessable_entity
        end
    end
    
    def delete
        Div.find(params[:id]).destroy
        redirect_to :action => 'list'
    end
    
    def random
        div_ids = Div.find( :all, :select => 'id' ).map( &:id )
        @divs = Div.find( (1..10).map { div_ids.delete_at( div_ids.size * rand)})
    end
    
    def div_params
        params.require(:div).permit(:text)
    end
    
end
