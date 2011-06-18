def flush_tags(pattern, tags_to_keep = 5)
  tags = `git tag -l #{pattern}`.split "\n"
  to_delete = tags[0..-(tags_to_keep+1)]
  `git tag -d #{to_delete.join(' ')}`
  remote_tags_to_delete = to_delete.collect do |tag|
    ":refs/tags/#{tag}"
  end.join(" ")
  `git push origin #{remote_tags_to_delete}`
  puts "#{pattern}: Deleted #{to_delete.count} tags, kept #{tags_to_keep} tags"
end

namespace :git do

  namespace :tags do
    task :flush do
      flush_tags('sandbox*', 5)
      flush_tags('staging*', 5)
      flush_tags('production*', 10)
      flush_tags('demo*', 0)
    end
  end

end
