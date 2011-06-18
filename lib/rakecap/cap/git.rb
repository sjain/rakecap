Capistrano::Configuration.instance.load do
  namespace :git do

    desc "apply git tag based on currently deployed stage and a timestamp. Clears out old tags"
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

  end
end
