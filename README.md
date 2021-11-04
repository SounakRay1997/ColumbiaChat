# README

1. Clone Repository
2. bundle install --without production
4. run rails db:migrate
5. run rails db:seed
6. run rails s
7. If you get issues related to webpack not finding application
run :
```
npm install --global yarn
rails webpacker:install
```
If you face permission issues during yarn installation
run :
sudo chown -R $USER:$GROUP ~/.config

8. You should be able to send messages using users.


To run tests :

9. Run :
```
cucumber features
bundle exec rspec
```
