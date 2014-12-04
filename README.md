# Nabu project #

## Installation ##

    bundle install
    rake db:migrate

# Ruby On Rails #

## Migrations ##
    bundle exec rails g migration add_message_to_posts message:text
    bundle exec rails g migration add_published_to_posts published:boolean

## DB commands ##
    bundle exec rake db:drop
    bundle exec rake db:create
    bundle exec rake db:migrate
    
## Update Model ##
    update_attribute(:published, false)
    
## Controllers ##
    render text: "text"
    render :new
    # Affiche la vue new
    
    def create
        @user = User.new(user_params)
    end
    
    private
    
    def user_params
        params.require(:user).permit(:name, :email)
    end
    
    before_action: require_login
    
    # Tout ce qui est mis dans ApplicationCotroller est utilisable partout
    # Ex: méthode require_login
    
## Formulaire ##
    <%= @post.errors.full_messages %>
    <%= form_for @post do |f| %>
        <%= f.text_field :message %>
        <%= f.select :user_id, User.all.map{|u| [u.name, u.id]} %>
        # User.all.map{|u| [u.name, u.id]} est à mettre dans le controller
        <%= f.submit %>

## Sessions ##
    # objet session (visible dans les controlleurs et les vues)
    session[:user_id] = 10
    current_user = User.find(session[:user_id])

## Gems ##
- Devise : gestion d'utilisateurs
- Simple Form : Formulaires
- mysql2 : Connexion MySQL
    
## Assets ##
- Asset Pipeline => Gestion du CSS / JS
- SCSS

## Links ##
- [rubular.com](http://rubular.com)
- [bundler.io](http://bundler.io)