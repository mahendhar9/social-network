module UsersHelper
  def friendship_status_button(user)
    case current_user.friendship_status(user)
      when "Not Friends"
        link_to "Add as Friend", friendships_path(user_id: user.id), method: :post, class: "btn btn-sm btn-success"
      when "Friends"
        link_to "Remove as Friend", friendship_path(id: current_user.find_friendship_with(user).id, user_id: user.id), method: :delete, class: "btn btn-sm btn-success"
      when "Requested"
        link_to "Cancel Request", friendship_path(id: current_user.find_friendship_with(user).id, user_id: user.id, cancel_request: true), method: :delete, class: "btn btn-sm btn-success"
      when "Pending"
        link_to "Accept Request", friendship_path(id: current_user.find_friendship_with(user).id, user_id: user.id), method: :put, class: "btn btn-sm btn-success"
    end
  end
end
