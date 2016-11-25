module.exports = (robot) ->
  slackGithub = {
    # key:github_id, value:slack_id
  }

  githubRepos = [
    # target_repository
  ]

  #github_webhook
  robot.router.post "/github/webhook/:room_name", (req, res) ->
    room_name = req.params
    githubRepository = req.body.repository

    if req.body.pull_request
      pullRequest = req.body.pull_request
      action = req.body.action
      switch action
        when 'closed'
          robot.messageRoom "#{room_name}", pullRequest.html_url
        when 'assigned'
          robot.messageRoom "#{room_name}", "@" + slackGithub[req.body.assignee.login] + "\n" + pullRequest.html_url
        when 'opend'
          issue = req.body.issue
          labels = []
          for label in issue.labels
            labels.push label.name
          robot.messageRoom "#{room_name}", issue.user.login + "\n"  + "Title：" + issue.title + "\n" + "Label：" + labels + "\n" + issue.html_url
      res.send 201
