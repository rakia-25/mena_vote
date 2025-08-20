class SettingsController < ApplicationController
  def index
    @setting = Setting.first
  end

  def update
    @setting = Setting.first
      if @setting.update(params_setting)
        redirect_to settings_path ,  notice: "Paramètre mis à jour avec succès!"
      else
        flash[:error] = "une erreur c'est produite"
        redirect_to settings_path
      end
  end

  private

  def params_setting
    params.require(:setting).permit(:vote)
  end
  
end
