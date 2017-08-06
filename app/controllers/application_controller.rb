class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  ## ========= Global Variables ========= ##

  def set_selected_status_core(choice_hash)
    $core_choice_hash = choice_hash
  end

  def get_selected_status_core
    $core_choice_hash
  end

  def set_selected_status_staffer(choice_hash)
    $staffer_choice_hash = choice_hash
  end

  def get_selected_status_staffer
    $staffer_choice_hash
  end

  def set_selected_status_location(choice_hash)
    $location_choice_hash = choice_hash
  end

  def get_selected_status_location
    $location_choice_hash
  end


  ## ========= Global Methods ========= ##

  ## Ordered List for Search/Filter Drop-downs (Multi-Select)
  def ordered_list(arr)
    arr.uniq!
    if arr.include?(nil)
      arr.delete(nil)
      arr.sort
    else
      arr.sort
    end
  end

  def list_of_states
    ['AK', 'AL', 'AR', 'AZ', 'CA', 'CO', 'CT', 'DC', 'DE', 'FL', 'GA', 'GU', 'HI', 'IA', 'ID', 'IL', 'IN', 'KS', 'KY', 'LA', 'MA', 'MD', 'ME', 'MI', 'MN', 'MO', 'MS', 'MT', 'NC', 'ND', 'NE', 'NH', 'NJ', 'NM', 'NV', 'NY', 'OH', 'OK', 'OR', 'PA', 'RI', 'SC', 'SD', 'TN', 'TX', 'UT', 'VA', 'VT', 'WA', 'WI', 'WV', 'WY']
  end

  def email_status_list
    ['True', 'False']
  end


  # ========== Detect User's Level(Role) ==========

  def basic_and_up
    unless current_user && (current_user.basic? || current_user.intermediate? || current_user.advanced? || current_user.admin?)
      flash[:alert] = "NOT AUTHORIZED [1]"
      redirect_to root_path
    end
  end

  def intermediate_and_up
    unless current_user && (current_user.intermediate? || current_user.advanced? || current_user.admin?)
      flash[:alert] = "NOT AUTHORIZED [2]"
      redirect_to root_path
    end
  end

  def advanced_and_up
    unless current_user && (current_user.advanced? || current_user.admin?)
      flash[:alert] = "NOT AUTHORIZED [3]"
      redirect_to root_path
    end
  end

  def admin_only
    unless current_user && current_user.admin?
      flash[:alert] = "NOT AUTHORIZED [4]"
      redirect_to root_path
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :work_phone, :mobile_phone, :department])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :work_phone, :mobile_phone, :department])
  end
end
