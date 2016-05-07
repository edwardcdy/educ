class PopupController < ApplicationController
    def list
        @popups = Popup.all
        render json: @popups
    end
    
    def show
        @popup = Popup.find(params[:id])
        render json: @popup 
    end
    
    def create
        @popup = Popup.new(popup_params)
        
        if @popup.save
            render json: {:status => "Successfully created and saved object"}
        else
            render json: @popup.errors, status: :unprocessable_entity
        end
    end
    
    def update
        @popup = Popup.find(params[:id])
        
        if @popup.update(popup_params)
            render json: {:status => "Successfully changed object"}
        else
            render json: @popup.errors, status: :unprocessable_entity
        end
    end
    
    def delete
        Popup.find(params[:id]).destroy
        redirect_to :action => 'list'
    end
    
    def delete_all
        Popup.delete_all
        redirect_to :action => 'list'
    end
    
    def random
        @popups = Popup.order("RAND()")
        render json: @popups
    end
    
    
    
    def popup_params
        params.require(:popup).permit(:text,:delete,:weight)
    end

end
