This is a file structure that can be uploaded to Heroku to get a 'hello world' application running. Here are the steps for doing so:

1) Clone this repo to your computer using the following command:

https://github.com/zmitton/heroku_thin_server_base.git


2) Create an app on Heroku by creating an account, going to 'apps' and clicking 'create a new app'

3) from your cloned repo, use the name of your new app to add a git remote with the following command:

heroku git:remote -a your-app-name


4) deploy to heroke using:

git push heroku master

