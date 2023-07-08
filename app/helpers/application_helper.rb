module ApplicationHelper
  def episode_favourite_icon(episode, user)
    count = episode.favourites.count
    if episode.favourited_by?(user)
      link_to(episode_favourite_path(episode), method: :delete) do
        "<i class='fa-solid fa-heart'></i> #{count}".html_safe
      end
    else
      link_to(episode_favourite_path(episode), method: :post) do
        "<i class='fa-regular fa-heart'></i> #{count}".html_safe
      end
    end
  end
end
