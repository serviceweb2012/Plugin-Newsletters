class NewslettersController < ApplicationController
   def create
     @newsletter = Newsletter.new(params[:newsletter])
     url = request.referer
     respond_to do |format|
       if @newsletter.save
         flash[:notice] = 'Email cadastrado com sucesso'
         format.html { redirect_to(url) }
         format.xml  { render :xml => @newsletter, :status => :created, :location => @newsletter }
       else
         flash[:notice] = 'Falha ao cadastrar email'
         format.html { redirect_to(url) }
         format.xml  { render :xml => @newsletter.errors, :status => :unprocessable_entity }
       end
     end
   end
end

