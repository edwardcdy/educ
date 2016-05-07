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
        
        if @div.weight.nil?
            @div.weight = 0
        end
        
        if @div.save
            render json: {:status => "Successfully created and saved object"}
        else
            render json: @div.errors, status: :unprocessable_entity
        end
    end
    
    def update
        @div = Div.find(params[:id])
        
        if @div.weight.nil?
            @div.weight = 0
        end
        
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
    
    def delete_all
        Div.delete_all
        redirect_to :action => 'list'
    end

    def random
        @divs = Div.limit(10).order("RAND()")
        render json: @divs
    end
    
    def increment
        @div = Div.find(params[:id])
        if @div.update(weight: @div.weight+1)
            render json: {:status => "Successfully added weight"}
        end
    end
    
    def div_params
        params.require(:div).permit(:text, :weight,:delete)
    end
    
end
