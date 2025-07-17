module MultimediasHelper
# new update carousel
  def random_media
    Multimedia.all.sample(3)
  end
end
