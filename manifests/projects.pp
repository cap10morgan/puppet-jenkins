define jenkins-project($name, $jenkins_url = "http://localhost:8080") {
  $jenkins_api_url = "${jenkins_url}/api"

  file {
    "/tmp/${name}_config.xml" :
      ensure  => present,
      content => template("jenkins/config.xml.erb"),
  }

  exec {
    "post-file" :
      command => "curl -F @${filename} $jenkins_api_url",
      unless  => "test -d /var/lib/jenkins/jobs/${name}",
  }
}

define jenkins-project-copy($name, $copy_from) {
  # TODO: Write this
}
