# frozen_string_literal: true

module ProfilesHelper
  def can_show_profile?(user)
    public_profile?(user) || current_user?(user)
  end

  private

  def public_profile?(user)
    user.public_profile?
  end

  def current_user?(user)
    current_user == user
  end
end
