module UsersHelper
  def gravatar_url(user, options = { size: 80 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
  end
  
  def image_for(user)
    if user.image
      image_tag "/uploads/user/image/#{user.id}/#{user.image}"
    else
      image_tag "kikuti.png"
    end
  end
end