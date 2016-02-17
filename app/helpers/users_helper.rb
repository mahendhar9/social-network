module UsersHelper
  def friendship_status_button(user)
    case current_user.friendship_status(user)
      when "Not Friends"
        "Add as Friend"
      when "Friends"
        "Remove as Friend"
      when "Requested"
        "Accept Request"
      when "Pendng"
        "Cancel Request" 
    end
  end
end
