module NewsletterHelper

  def gera_newsletter
    html = %()
    html << "<form action='/newsletters' method='post'>"
    html << "<input name='authenticity_token' type='hidden' value='#{form_authenticity_token}' />"
      html << "<label for='name'> Nome"
        html << "<input type='text' name='newsletter[name]' value='Digite seu nome'>"
      html << "</label>"
      html << "<label for='email'> Email"
        html << "<input type='text' name='newsletter[email]' value='Digite um email válido'>"
      html << "</label>"
      html << "<input type='submit' value='Inscrever-se'>"
    html << '</form>'
    html
  end

end

