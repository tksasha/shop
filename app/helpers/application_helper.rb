module ApplicationHelper
  def display_user_blocked blocked_at
    blocked_at ? l(blocked_at, format: :short) : t(false)
  end
end
