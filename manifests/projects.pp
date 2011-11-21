define jenkins-git-project (
    $name = $title,
    $git_url
) {
  $scm = "git"

  $jenkins_api_url = "${jenkins_url}/api"

  file { "/tmp/${name}_config.xml" :
    ensure  => present,
    content => template("jenkins/config.xml.erb"),
  }

  exec { "post-file" :
    command => "curl -F @/tmp/${name}_config.xml $jenkins_api_url",
    unless  => "test -d /var/lib/jenkins/jobs/${name}",
  }
}

define jenkins-github-project (
    $name = $title,
    $github_user,
    $github_repo,
    $github_push_trigger = true,
    $build_schedule = undef,
    $jenkins_url = "http://localhost:8080"
) {

  jenkins-git-project { $name :
    git_url => "git@github.com:${github_user}/$github_repo.git",
  }
}

define jenkins-project-copy($name, $copy_from) {
  # TODO: Write this
}
