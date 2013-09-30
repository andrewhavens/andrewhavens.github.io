require 'json'

json = File.read('posts.json')
posts = JSON.parse json

# body_html
# body_markdown
# excerpt
# id
# published_on
# title

posts.each do |p|

  date = p['published_on']
  title = p['title']
  title_slug = title.downcase.gsub(' ','-')
  filename = "_posts/#{date}-#{title_slug}.md"

  File.open(filename, 'w') do |f|
    f.puts '---'
    f.puts 'layout: post'
    f.puts "title: #{title}"
    f.puts "date: #{date}"
    f.puts "permalink: /posts/#{p['id']}/#{title_slug}"
    f.puts '---'
    f.puts p['body_markdown']
  end

end