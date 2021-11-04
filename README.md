# README

## Columbia Chat
## Group Number : 4


Team member names and UNIs :


1. Chinmay Garg (UNI: cg3286)
2. Umang Raj (UNI: ur2136)
3. Harrison Groll (UNI: hsg2136)
4. Sounak Ray (UNI: sr3846)


Step by step instructions to run the program locally, this includes setting any necessary environment variables that contain keys or secrets :


1. Run

   git clone git@github.com:SounakRay1997/ESaaS-Project-iter1-submission.git

2. Navigate to Project Root Directory

   cd ESaaS-Project-iter1-submission

3. Run

   bundle install --without production

4. Run 

   rails db:migrate

5. Run 

   rails db:seed

6. Run (to fire up the rails server)

   rails s

7. If you get issues related to webpack not finding the application after opening the application on the browser, run in the project directory root:

   npm install --global yarn
   rails webpacker:install


   If you face permission issues during yarn installation run : 

   sudo chown -R     $USER:$GROUP ~/.config

8. Open the app on your local browser using localhost:3000.

To run tests :

9. Run Cucumber Tests using:

   cucumber features

   (if this command fails use : bundle exec cucumber features)
   
   Run RSpec Tests using:

   bundle exec rspec


Heroku Link :


     https://esaas-chat.herokuapp.com/


Link to GitHub Repository :


     https://github.com/SounakRay1997/ESaaS-Project-iter1-submission


Documentation:


We present to you ColumbiaChat(v1.0). In this version we present a few simple pages with html forms which performs all the basic functions that you would expect your everyday chat application to perform. 
Features implemented in iteration 1 (v 1.0) :
1. SignUp functionality for users to sign up using username, email and password.
2. SignIn functionality for users to sign into the chat application using username.
3. Chat functionality from one user to another user.
4. Chat functionality from one user onto a ‘public’ group(room).
5. Create Room functionality - Each room created currently is public by default and visible to all the users in the database.
6. SignOut functionality


In successive iterations, we would work towards implementing LionMail authentication checks for emails during Signup and other validations. We would also be working towards adding new features to the chat functionality such as making groups discoverable only to specific users.


Test Coverage : 100% (RSpec + Cucumber) 
All models and controllers are being covered.


We have excluded folders app/mailers, app/jobs and app/channels from SimpleCov coverage because these files do not contain any code (false negatives).


Cucumber Features (Located in /features):
1. create_rooms.feature - Checks for room creation functionality
2. group_chat.feature - Checks for group chat functionality
3. private_chat.feature - Checks for one on one chat functionality
4. signup.feature - Checks for sign up new user functionality


RSpec Tests (Located in /spec):
Covers all models and controllers.
