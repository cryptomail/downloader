require 'octokit'
require 'pry'

MAX_CLONE_PER_INVOCATION = 30
CLONE_ROOT = "../Z2SEARCH"
REPO_FILE = "repositories.txt"


def reponame(gitpath)
  arr = gitpath.strip.split('/')
  name = arr[arr.length-1].strip.split(".git")[0]
  name
end

x = 0
lines = []

File.readlines(REPO_FILE).each do |line|
  lines << line
end

reponum = 0

while x < MAX_CLONE_PER_INVOCATION && reponum < lines.length

  puts "working on repo #{lines[reponum].strip} reponame: #{reponame(lines[reponum])}"

  dirname = "#{CLONE_ROOT}/#{reponame(lines[reponum])}"

  if(Dir.exist?(dirname) == false)
    if x < MAX_CLONE_PER_INVOCATION
      system("echo \"cd #{CLONE_ROOT}\" && echo \"git clone #{lines[reponum]} \"&& cd #{CLONE_ROOT} && git clone #{lines[reponum]}")
    else
      puts "done"
      return
    end
    x = x + 1
  end

  reponum = reponum + 1
end
puts "done"


