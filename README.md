
# README

  

## Columbia Chat (Group Number : 4)

  
  

Team member names and UNIs :

  
  

1. Chinmay Garg (UNI: cg3286)

2. Umang Raj (UNI: ur2136)

3. Harrison Groll (UNI: hsg2136)

4. Sounak Ray (UNI: sr3846)

  
  

Step by step instructions to run the program locally, this includes setting any necessary environment variables that contain keys or secrets :

  
  

1. Run

  

    ```git clone git@github.com:SounakRay1997/ESaaS-Project-iter1-submission.git```

  

2. Navigate to Project Root Directory (Make sure you’re on the ‘main’ branch)

  

    ```cd ESaaS-Project-iter1-submission```

  

3. Run

  

    ```bundle install --without production```

  

4. Run

  

    ```rails db:migrate```

  

5. Run (to fire up the rails server)

  

    ```rails s```

  

6. If you get issues related to webpack not finding the application after opening the application on the browser, run in the project directory root:

  

   ``` npm install --global yarn
    
    rails webpacker:install```

  
  

If you face permission issues during yarn installation run :

  

    ```sudo chown -R $USER:$GROUP ~/.config```

  

7. Open the app on your local browser using localhost:3000.

  

To run tests :

  

8. Run Cucumber Tests using:

  

    ```cucumber features```

  

(if this command fails use : bundle exec cucumber features)

Run RSpec Tests using:

  

    ```bundle exec rspec```

  
  

Heroku Link :

  
  

https://columbia-chat.herokuapp.com/signin

  
  

Link to GitHub Repository :

  
  

https://github.com/SounakRay1997/ESaaS-Project-iter1-submission

  
  

Documentation:

  
  

In this fully functional, dynamic chat application, we now present to you ColumbiaChat(v2.0) with the following complete features:

  

1. SignUp functionality for users to sign up using full name, username, email and password. The page also contains basic validation checks to ensure uniqueness of usernames, for LionMail authentication and for password matching.

  

2. LionMail Verification: Every user who signs up using their Lionmail receives a verification link on their email address. An attempt to sign up using a non-Lionmail account will not be successful. Upon clicking on the verification link, an account is created for them on the ColumbiaChat platform.

  

3. SignIn functionality for users to sign into the chat application using username and password.

  

4. One to One Chat functionality from one user to another user shown under the ‘Direct Messages’ navbar.

  

5. Create Public Groups (Discoverable to All): Create groups that are visible to all users who have signed up on the application.

To test this flow,

(a) Go to Create New Room option inside the Rooms navbar.

(b) Add a unique Room Name.

(c ) Select Private field value as “No”.

(d) Leave the default value which is 0.0 for Distance (feet) option (This creates a public room visible to everyone).

(e ) Click on “Create Room” Button.

(f) All the users should now be able to see the ‘public’ group created.

  

6. Create Public Groups (Discoverable within a Certain Radius): Create groups that are discoverable only by users who are currently signed in within the radius.

To test this flow,

(a) Go to Create New Room option inside the Rooms navbar.

(b) Add a unique Room Name.

(c ) Select Private field value as “No”.

(d) Add the Distance (feet) value upto which you want your room to be discoverable.

(e ) Click on “Create Room” Button.

(g) Users who are located within the ‘distance’ that was inputted by you should now be able to view and communicate in the group you just created. Other users that are out of the radius will not be able to see these discoverable groups. You will also be able to see an embedded interactive Google Maps frame displaying the location where the group was created. Additionally, users are also able to see how far they are from where the group was created on the top beside the group name upon opening the discoverable group. (Example : 13 feet away)

  

NOTE: You will have to enable location services on your browser to use this functionality.

Public rooms have a corresponding ‘Open Lock’ icon beside them.

  

7. Create Private Groups with only certain users: Create groups that only contain selected users being added as group members.

To test this flow,

(a) Go to Create New Room option inside the Rooms navbar.

(b) Add a unique Room Name.

(c ) Select Private field value as “Yes”.

(d) Now, select one or more users that you want to add to this private group using the field ‘Add users to private room’.

(e ) Click on “Create Room” Button.

(f) Users who have been added as members of this private group will be able to view and message on the groups. This group will not be visible to other users of the application, who have not been added as members of the group.

  

Private groups have a corresponding ‘Closed Lock’ icon beside them.

  

8. Public Course Groups and filtering using Department Code: We also now have course groups available on the application that have been populated using the course data available from SSOL. These groups cannot be created manually by users. We have an ‘Open Book’ icon corresponding to these groups.

To test this flow,

(a) Select the appropriate (Example: COMS for Computer Science) department code from ‘Search Room’ dropdown.

(b) Click on ‘Search’ Button.

(c ) You will now be able to see Course Groups corresponding to the Computer Science department, along with the other private and discoverable groups you’re a part of.

  

By default, the dropdown option selected is ‘ALL’, and this will display all the course groups from all the departments corresponding to the courses that are offered in these departments (Like Machine Learning for COMS, Accounting For Value for ACCT etc.)

  

9. SignOut functionality

  
  

Test Coverage : 100% (RSpec + Cucumber)

All models and controllers are being covered.

The only scenario that couldn’t be tested by Cucumber was if the emails are being received on the LionMail email id and the verification of the contents that are being sent out in this email. This cannot be tested using Cucumber as we would require private and confidential credentials of someone’s LionMail account to be added and pushed along with the code to test this functionality using Selenium and Cucumber.

  

We have added RSpec tests to test ActionMailer functionality so that we're still able to test the working of this functionality and if it performs the intended job (which is verification). We also have Cucumber tests to test if verification of email is performed on the frontend side.

  

We have excluded folders app/jobs and app/channels from SimpleCov coverage because these files do not contain any code (false negatives).

  
  

Cucumber Features (Located in /features):

1. create_rooms.feature - Test room creation functionality.

2. distance_rooms.feature – Tests discoverable rooms creation functionality.

3. filter_by_department.feature – Tests course group filtering.

4. group_chat.feature – Tests the group chat functionality.

5. private_chat.feature – Tests one to one chat functionality.

6. signup.feature – Tests the sign up functionality.

7. signin.feature – Tests the sign in functionality.

  
  

RSpec Tests (Located in /spec):

Covers all models, mailer and controllers.

