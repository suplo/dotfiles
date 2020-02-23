" Run Rubocop auto-correct over modified files
function rubo
  cd (pwd)

  git status --porcelain | cut -c4- | grep '\.rb\|\.rake$' | grep -v "\->" | grep -v 'db/schema.rb' | xargs bundle exec rubocop --auto-correct
end
