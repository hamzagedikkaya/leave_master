# frozen_string_literal: true

module Users
  class SessionsController < Devise::SessionsController
    prepend_before_action :require_no_authentication, only: %i[new create]
    prepend_before_action :allow_params_authentication!, only: :create
    prepend_before_action :verify_signed_out_user, only: :destroy
    prepend_before_action(only: %i[create destroy]) { request.env["devise.skip_timeout"] = true }
    before_action :authenticate_user!, only: %i[two_factor_setup verify_two_factor]

    # GET /resource/sign_in
    def new
      self.resource = resource_class.new(sign_in_params)
      clean_up_passwords(resource)
      yield resource if block_given?
      respond_with(resource, serialize_options(resource))
    end

    # POST /resource/sign_in
    def create
      self.resource = warden.authenticate!(auth_options)

      if resource.present?
        handle_authenticated_user(resource)
      else
        handle_failed_authentication
      end
    end

    # DELETE /resource/sign_out
    def destroy
      signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
      set_flash_message! :notice, :signed_out if signed_out
      yield if block_given?
      respond_to_on_destroy
    end

    def two_factor_setup
      @user = current_user
      render "devise/sessions/two_factor"
    end

    def verify_two_factor
      @user = find_user
      return unless @user

      if @user.verify_otp(params[:otp_code])
        handle_successful_verification
      else
        handle_failed_verification
      end
    end

    protected

    def sign_in_params
      devise_parameter_sanitizer.sanitize(:sign_in)
    end

    def serialize_options(resource)
      methods = resource_class.authentication_keys.dup
      methods = methods.keys if methods.is_a?(Hash)
      methods << :password if resource.respond_to?(:password)
      { methods: methods, only: [:password] }
    end

    def auth_options
      { scope: resource_name, recall: "#{controller_path}#new", locale: I18n.locale }
    end

    def translation_scope
      "devise.sessions"
    end

    private

    # Check if there is no signed in user before doing the sign out.
    #
    # If there is no signed in user, it will set the flash message and redirect
    # to the after_sign_out path.
    def verify_signed_out_user
      return unless all_signed_out?

      set_flash_message! :notice, :already_signed_out

      respond_to_on_destroy
    end

    def all_signed_out?
      users = Devise.mappings.keys.map { |s| warden.user(scope: s, run_callbacks: false) }

      users.all?(&:blank?)
    end

    def respond_to_on_destroy
      # We actually need to hardcode this as Rails default responder doesn't
      # support returning empty response on GET request
      respond_to do |format|
        format.all { head :no_content }
        format.any(*navigational_formats) { redirect_to after_sign_out_path_for(resource_name), status: Devise.responder.redirect_status }
      end
    end

    def handle_authenticated_user(resource)
      if resource.otp_required_for_login?
        sign_out(resource)
        session[:user_id] = resource.id
        redirect_to two_factor_setup_path
      else
        complete_sign_in(resource)
      end
    end

    def complete_sign_in(resource)
      set_flash_message!(:notice, :signed_in)
      sign_in(resource_name, resource)
      yield resource if block_given?
      respond_with resource, location: after_sign_in_path_for(resource)
    end

    def handle_failed_authentication
      flash.now[:alert] = I18n.t("devise.sessions.invalid")
      render :new
    end

    def find_user
      user = User.find_by(id: session[:user_id])
      return user if user

      redirect_to new_user_session_path, alert: I18n.t("devise.sessions.user_not_found")
    end

    def handle_successful_verification
      sign_in(@user)
      redirect_to root_path, notice: I18n.t("devise.sessions.signed_in")
    end

    def handle_failed_verification
      flash[:alert] = I18n.t("devise.sessions.invalid_otp")
      redirect_to two_factor_setup_path
    end
  end
end
