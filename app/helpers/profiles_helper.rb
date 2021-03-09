# frozen_string_literal: true

module ProfilesHelper
  def public_profile?(user)
    user.public_profile?
  end

  def current_user?(user)
    current_user == user
  end
end
