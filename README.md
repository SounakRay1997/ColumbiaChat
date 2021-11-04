# README

(1) Run
    git clone git@github.com:SounakRay1997/ESaaS-Project-iter1-submission.git
(2) cd ESaaS-Project-iter1-submission

(3) Run
```
        bundle install --without production
```
(4) Run
```
    rails db:migrate
```
(5) Run 
```
    rails db:seed
```
(6) Run
```
    rails s
```
If you get issues related to webpack not finding the application on opening the application on the browser. Run:
```
       npm install --global yarn
       rails webpacker:install
```

   If you face permission issues during yarn installation run : 
   ```
   sudo chown -R $USER:$GROUP ~/.config
   ```
   
(7) Open the app on your local browser using ```localhost:3000```.
