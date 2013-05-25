## Demo

Demo application can be found [here] (http://hyperpdf-example-app.herokuapp.com).

## Installing

Clone repository to your local machine

    $ git clone git://github.com/redfield/hyperpdf_example_app.git
  
Navigate to hyperpdf_example_app directory and install missing gems
  
    $ cd hyperpdf_example_app && bundle install
    
Create new heroku application and install HyperPDF add-on

    $ heroku create
    $ heroku addons:add hyperpdf
    
Add HyperPDF credentials and RACK_ENV variable to the .env file

    $ heroku config -s | grep HYPERPDF_ >> .env
    $ echo "RACK_ENV=development" >> .env
    
If you want to upload documents to AWS S3, you need to [give permissions](https://devcenter.heroku.com/articles/hyperpdf#s3-permissions) 
before. Also you should replace 'hyperpdf_test' with your backet name in `app/controllers/pdf_controller.rb`
    
Run application locally using [Foreman](https://devcenter.heroku.com/articles/procfile#developing-locally-with-foreman)

    $ foreman start
    
Deploy application to Heroku

    $ git push heroku master
    $ heroku open
    
## Links

* [Demo](http://hyperpdf-example-app.herokuapp.com)
* [Add-on description and plans](https://addons.heroku.com/hyperpdf)
* [Full documentation](https://devcenter.heroku.com/articles/hyperpdf)
* [Support](mailto:support@hyper-pdf.com)
