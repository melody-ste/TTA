module MultimediasHelper

  def random_media
    Multimedia.all.sample(3)
  end
end
