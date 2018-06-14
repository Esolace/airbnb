class UsersController < Clearance::UsersController 
    if respond_to?(:before_action)
        before_action :redirect_signed_in_users, only: [:create, :new]
        skip_before_action :require_login, only: [:create, :new], raise: false
        skip_before_action :authorize, only: [:create, :new], raise: false
      else
        before_filter :redirect_signed_in_users, only: [:create, :new]
        skip_before_filter :require_login, only: [:create, :new], raise: false
        skip_before_filter :authorize, only: [:create, :new], raise: false
      end
    
      def new
        @user = User.new
        render template: "users/new"
      end
    
      def create
        @user = user_from_params
    
        if @user.save
          sign_in @user
          redirect_back_or url_after_create
        else
          render template: "users/new"
        end
      end
    
      def show 
        @user =  User.find(params[:id])
        if @user != current_user 
          redirect_to '/'
        end
      end 

      private
    
      def avoid_sign_in
        warn "[DEPRECATION] Clearance's `avoid_sign_in` before_filter is " +
          "deprecated. Use `redirect_signed_in_users` instead. " +
          "Be sure to update any instances of `skip_before_filter :avoid_sign_in`" +
          " or `skip_before_action :avoid_sign_in` as well"
        redirect_signed_in_users
      end
    
      def redirect_signed_in_users
        if signed_in?
          redirect_to Clearance.configuration.redirect_url
        end
      end
    
      def url_after_create
        Clearance.configuration.redirect_url
      end
    
      def user_from_params
        first_name = user_params.delete(:first_name)
        last_name = user_params.delete(:last_name)
        email = user_params.delete(:email)
        country = user_params.delete(:country)
        password = user_params.delete(:password)
        avatar = user_params.delete(:avatar)
        moderator = false
        user = true
        if user_params[:moderator_role] == "1"
          moderator = true
          user = false
        end
        User.new(first_name: first_name, last_name: last_name, email: email, country: country, password: password, moderator_role: moderator, user_role: user, avatar: avatar)
      end
    
      def user_params
        params.require(:user).permit(:email, :password, :avatar, :moderator_role, :first_name, :last_name, :country) || Hash.new
      end
end 