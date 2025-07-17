module MultimediasHelper



  def all_media
    Multimedia.all
  end

  def media_portfolio(specialization)
    medias = []

    @specializations = Specialization.includes(architects: { portfolios: :multimedias })
    @specializations.each do |spec|
      if spec.id == specialization.id
        spec.architects.each do |architect|
          architect.portfolios.each do |portfolio|
            portfolio.multimedias.each do |media|
              medias << media
            end
          end
        end
      end
    end
    medias
  end

  def random_media
    Multimedia.all.sample(3)
  end
end
