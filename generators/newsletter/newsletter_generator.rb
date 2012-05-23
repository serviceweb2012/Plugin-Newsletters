class NewsletterGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      m.directory(File.join('db/', 'migrate'))

      #copia estrutura mvc
      src = File.join(File.dirname(__FILE__), "templates", "app")
      dest = destination_path('.')
      FileUtils.cp_r src, dest

      #cria migracao
	    m.file 'db/create_newsletters.rb', "db/migrate/#{(Time.now).strftime("%Y%m%d%H%M%S")}_create_newsletters.rb"

      add_rotas
      add_ptbr
    end
  end
  protected
  def add_rotas
		path = destination_path('config/routes.rb')
		content = File.read(path)

		sentinel = "map.resources :newsletters"
		if existing_content_in_file(content, sentinel)
			env = "ActionController::Routing::Routes.draw do |map|"
			gsub_file 'config/routes.rb', /(#{Regexp.escape(env)})/mi do |match|
        "#{match}\nmap.resources :newsletters"
			end
		end

		sentinel = "admin.resources :newsletters"
		if existing_content_in_file(content, sentinel)
			env = "map.namespace :admin do |admin|"
			gsub_file 'config/routes.rb', /(#{Regexp.escape(env)})/mi do |match|
        "#{match}\nadmin.resources :newsletters"
			end
		end
	end

  def add_ptbr
		path = destination_path('config/locales/pt-BR.yml')
		content = File.read(path)

		sentinel = "question:"
		if existing_content_in_file(content, sentinel)
			env = " models:"
			gsub_file 'config/locales/pt-BR.yml', /(#{Regexp.escape(env)})/mi do |match|
        "#{match}\n        newsletter:\n            one: \"Newsletter\"\n            other: \"Newsletters\""
			end

			env = " attributes:"
			gsub_file 'config/locales/pt-BR.yml', /(#{Regexp.escape(env)})/mi do |match|
        "#{match}\n        newsletter:\n            name: \"Nome\"\n            email: \"Email\"\n            situation: \"Situação\""
      end
		end

  end


  def existing_content_in_file(content, er)
    match = /(#{Regexp.escape(er)})/mi
    match = match.match(content)
    match.nil?
  end

  def gsub_file(relative_destination, regexp, *args, &block)
    path = destination_path(relative_destination)
    content = File.read(path).gsub(regexp, *args, &block)
    File.open(path, 'wb') { |file| file.write(content) }
  end


end

