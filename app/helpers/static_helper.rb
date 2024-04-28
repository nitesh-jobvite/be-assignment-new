module StaticHelper
  def get_name(user_id)
    user = User.find_by(id: user_id)
    if user
      return user.name
    end
  end
end
