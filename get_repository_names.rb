require 'octokit'

FILENAME = "repositories.txt"
ORGANIZATION = "twitch"
# Provide authentication credentials
#Set access_token instead of login and password if you use personal access token
token = ENV["GITHUB_TOKEN"]
client = Octokit::Client.new(:access_token => "#{token}")

git_urls = []
repos = client.org_repos(ORGANIZATION)
puts "Getting repositories"
while repos && repos.count > 0
  repos.each do |r|
    git_urls << r.git_url
    end
  repos = nil
  if client.last_response.rels[:next]
    repos = client.get(client.last_response.rels[:next].href)
  end
end
puts "Done getting repositories"
File.delete(FILENAME) if File.exist?(FILENAME)
File.write(FILENAME, git_urls.join("\n"), mode: "w")

puts "File written to #{FILENAME}"
