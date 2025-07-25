class ValidatedMailMailer < ApplicationMailer
  default from: "trouvetonarchi@gmail.com"

 def project_validated_client(project)
    @project = project
    @client = project.user
    @architect = project.architect&.user

    mail(
      to: @client.email,
      cc: @architect.email,
      subject: "Votre projet a été validé par l'architecte"
    )
  end
end
