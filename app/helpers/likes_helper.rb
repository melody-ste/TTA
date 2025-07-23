module LikesHelper


  def architect_likes_count(architect)
    architect.likes.count
  end


  def architect_liked_by_user?(architect)
    architect.likes.exists?(client_id: current_user.id)
  end

  def heart_icon(architect)
    if architect_liked_by_user?(architect)
      content_tag(:i, '', class: 'fa-solid fa-heart text-danger heart-icon', data: { liked: true }, title: 'Retirer des favoris')
    else
      content_tag(:i, '', class: 'fa-regular fa-heart text-muted heart-icon', data: { liked: false }, title: 'Ajouter aux favoris')
    end
  end
end
