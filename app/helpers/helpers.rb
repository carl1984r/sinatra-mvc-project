class Helpers

  def self.current_user(session_hash)
    @user = User.find(session_hash[:user_id])
  end

  def self.is_logged_in?(session_hash)
    !!session_hash[:user_id]
  end

  def self.flash_types
    [:empty_signup_form_error, :login_error, :logged_out, :empty_content_error, :review_created, :please_login, :login_to_edit, :wrong_user_edit, :no_content_edit, :delete_error, :wrong_user_delete, :success, :create_error, :edit_successful, :no_review]
  end

end
