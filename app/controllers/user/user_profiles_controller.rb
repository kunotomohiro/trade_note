class User::UserProfilesController < User::ApplicationController

  def new
    @user_profile = UserProfile.new
  end

  def create
    @user_profile = current_user.build_user_profile(user_profile_params)
    if @user_profile.save
      redirect_to user_trades_path
    else
      render "new"
    end
  end

  def edit
    @user_profile = current_user.user_profile
  end

  def update
    if current_user.user_profile.update(user_profile_params)
      redirect_to user_trades_path
    else
      render "edit"
    end
  end

  private

  def user_profile_params
    params.require(:user_profile).permit(:nickname, :avatar)
  end
end