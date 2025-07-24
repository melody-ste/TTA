class UserProjectMailMailer < ApplicationMailer
  default from: "trouvetonarchi@gmail.com"

  def new_project_client(project)
    @project = project
    @client = project.user
    mail(to: @client.email, subject: "Demande de projet en cours de validation")
  end

  def new_project_architect(project)
    @project = project
    @architect = project.architect.user
    mail(to: @architect.email, subject: "Nouveau projet à valider")
  end
end
