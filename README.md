## Demo

Demo application can be found [here] (http://hypdf-example-app.herokuapp.com).

## Installing

Clone repository to your local machine

    $ git clone git://github.com/redfield/hypdf_example_app.git
  
Navigate to hypdf_example_app directory and install missing gems
  
    $ cd hypdf_example_app && bundle install
    
Create new heroku application and install HyPDF add-on

    $ heroku create
    $ heroku addons:add hypdf
    
Add HyPDF credentials and RACK_ENV variable to the .env file

    $ heroku config -s | grep HYPDF_ >> .env
    $ echo "RACK_ENV=development" >> .env
    
If you want to upload documents to AWS S3, you need to [give permissions](https://devcenter.heroku.com/articles/hypdf#s3-permissions) 
before. Also you should replace 'hypdf_test' with your bucket name in `app/controllers/pdf_controller.rb`
    
Run application locally using [Foreman](https://devcenter.heroku.com/articles/procfile#developing-locally-with-foreman)

    $ foreman start
    
Deploy application to Heroku

    $ git push heroku master
    $ heroku open
    
## Links

* [Demo](http://hypdf-example-app.herokuapp.com)
* [Add-on description and plans](https://addons.heroku.com/hypdf)
* [Full documentation](https://devcenter.heroku.com/articles/hypdf)
* [Support](mailto:support@hypdf.com)
