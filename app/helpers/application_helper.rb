module ApplicationHelper
  def pending_received_requests_count
    current_user.pending_received_requests.map(&:user).size
  end
end
