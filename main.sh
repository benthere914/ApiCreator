clear
rm -rf .git
echo "What was the repo name?"
read project_name
echo "Who is the repo under?"
read userName
python create_project.py
python3 -m venv ./venv
source venv/bin/activate
pipenv install
git init
git add .
git commit -m "init"
git branch -M main
git remote add origin https://github.com/$userName/$project_name.git
git push -u origin main

heroku login
while true
do
 clear
 result=$(heroku apps:create $project_name)
 if [[ "$result" == *"$project_name"* ]];
 then
  echo 'success'
  break
 fi
 echo "$project_name not valid. Please try again"
 read project_name
done
heroku addons:create heroku-postgresql:hobby-dev
cat postgre.sql | heroku pg:psql --app $project_name
heroku config:set SECRET=$secret
git push heroku main
