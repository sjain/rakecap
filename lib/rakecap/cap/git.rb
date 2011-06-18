Capistrano::Configuration.instance.load do
  namespace :git do

    task :tag, :except => { :no_release => true } do
      new_tag = "#{stage}_#{Time.now.strftime("%Y%m%d%H%M%S")}"
      cmd = [
        "git checkout #{branch}",
        "git tag -a #{new_tag} -m \"rails_env: #{rails_env}, stage: #{stage}\" #{real_revision}",
        "git push origin #{new_tag}",
        "rake git:tags:flush",
      ].join(";")
      puts "Executing: #{cmd}"
      `#{cmd}`
    end

    task :change_log do
      last_commit_tag = `git tag -l '#{stage}*'`.split("\n").last
      cmd = "git log --format=oneline --abbrev-commit #{last_commit_tag}..#{branch}"
      commit_log = `#{cmd}`
      Notifier.deliver_deploy_notification("Deployed #{branch} to #{stage}: commit log", commit_log)
    end

  end
end
