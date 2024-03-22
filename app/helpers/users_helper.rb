# typed: false
# frozen_string_literal: true

module UsersHelper
  def profile_image(user, size = 80)
    url = "https://secure.gravatar.com/avatar/#{user.gravatar_id}?s=#{size}"
    image_tag(url, alt: user.name, class: "photo-width")
  end
end
