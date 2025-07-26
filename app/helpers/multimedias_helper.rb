module MultimediasHelper
  def random_media
    Multimedia
      .includes(:file_attachment, project: :architect)
      .joins(:file_attachment)
      .where(projects: { portfolio: true, status: "termine" })
      .references(:projects)
      .sample(3)
  end
end
