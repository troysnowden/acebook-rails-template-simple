# AceBook Team Eccelsia

## Jira Board
https://makers-team-meridian.atlassian.net/jira/software/projects/AB/boards/1

## Quickstart

First, clone this repository. Then:

```bash
> bundle install
> bin/rails db:create
> bin/rails db:migrate

> bundle exec rspec # Run the tests to ensure it works
> bin/rails server # Start the server at localhost:3000
```

## git workflow
```git checkout main```
```git pull```
```git checkout -b "MBNB-[ticket_num]-brief-title"```
```make changes```
```git add .```
```git commit -m```
```repeat as necessary```
```git checkout main```
```git pull```
```git checkout [branch-name]```
```git merge main```
```git commit -a -m "merge in main"```
```git push```
```submit pull request```

## Troubleshooting

If you don't have Node.js installed yet, you might run into this error when running rspec:

```
ExecJS::RuntimeUnavailable:
  Could not find a JavaScript runtime. See https://github.com/rails/execjs for a list of available runtimes.
 ```

Rails requires a Javascript runtime to work. The easiest way is to install Node by running `brew install node` - and then run `bundle exec rspec` again
