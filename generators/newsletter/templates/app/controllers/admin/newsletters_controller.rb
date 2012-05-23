class Admin::NewslettersController < ApplicationController
  layout 'admin'
  before_filter :authorize

   def index
     @newsletters = Newsletter.paginate(:page => params[:page], 
                            :per_page => session[:per_page])
     @count = @newsletters.length

     respond_to do |format|
       format.html # index.html.erb
       format.xml  { render :xml => @newsletters }
     end
   end

   def show
     @newsletter = Newsletter.find(params[:id])
     respond_to do |format|
       format.html { render :layout => 'show' }
       format.xml  { render :xml => @newsletter }
     end
   end

   def new
     @newsletter = Newsletter.new

     respond_to do |format|
       format.html # new.html.erb
       format.xml  { render :xml => @newsletter }
     end
   end

   def edit
     @newsletter = Newsletter.find(params[:id])
   end

   def create
     @newsletter = Newsletter.new(params[:newsletter])

     respond_to do |format|
       if @newsletter.save
         flash[:notice] = 'Newsletter foi criada com sucesso.'
         format.html { redirect_to(new_admin_newsletter_path) }
         format.xml  { render :xml => @newsletter, :status => :created, :location => @newsletter }
       else
         format.html { render :action => "new" }
         format.xml  { render :xml => @newsletter.errors, :status => :unprocessable_entity }
       end
     end
   end

   def update
     @newsletter = Newsletter.find(params[:id])
     url = admin_newsletters_path+"?search=#{params[:search]}"

     respond_to do |format|
       if @newsletter.update_attributes(params[:newsletter])
         flash[:notice] = 'Newsletter foi atualizada com sucesso.'
         format.html { redirect_to(url) }
         format.xml  { head :ok }
       else
         format.html { render :action => "edit" }
         format.xml  { render :xml => @newsletter.errors, :status => :unprocessable_entity }
       end
     end
   end

   def destroy
     @newsletter = Newsletter.find(params[:id])
     @newsletter.destroy

     respond_to do |format|
       format.html { redirect_to(admin_newsletters_url) }
       format.xml  { head :ok }
     end
   end
   

   protected
end