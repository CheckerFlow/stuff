class PagesController < ApplicationController
  include ApplicationHelper

  before_action do 
    set_meta_description("Klar Schiff ist eine App um ein digitales Abbild von deinen Dingen, die unterschiedlichen Ablagen in mehreren Räumen verteilt sind, zu erstellen. Klar Schiff hilft dir eine Überblick über die Dinge zu behalten, sie schneller zu finden und auszumisten.")
  end

  before_action :set_early_access_request, :only => [:about, :landing, :landing2]

  layout "landing", except: [:home, :help]

  def home
    title("Home")    
  end

  def help
    title("Hilfe")
  end

  def about
    title("Die Geschichte hinter Klar Schiff")
  end

  def landing
    title("Gewinne den Überblick über deine Dinge")
  end

  def landing2
    title("Gegenstände organisieren")
  end

  def use_case_1
  end

  def use_case_2
  end

  def use_case_3
  end  

  private 

    def set_early_access_request
      @early_access_request = EarlyAccessRequest.new
    end
end
