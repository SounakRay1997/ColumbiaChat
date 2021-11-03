# README

1. Clone Repository
2. run rails db:migrate
3. run rails db:seed
4. run rails s
5. If you get issues related to webpack not finding application
run :
```
npm install --global yarn
rails webpacker:install
```
If you face permission issues during yarn installation
run :
sudo chown -R $USER:$GROUP ~/.config

5. You should be able to send messages using users.
6. To create users:
run:
rails console
User.create(username:'username', email:'email', password:'password')
