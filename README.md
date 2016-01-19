# FancyFeed

![FancyFeed](http://cdn0.rubylane.com/shops/1089582/MCGP1514.1L.jpg)

## Feasting on Feeds

FancyFeed is a project of students in the 4th cohort of Ada Developers Academy. The team includes: [Ricky Hougland](https://github.com/hougland), [Jenna Nichols] (https://github.com/jennaplusplus), [Daphne Gold](https://github.com/daphnegold), and [Kelley Devlin](https://github.com/Kedevlin).

To view original project requirements, [click here](https://github.com/Ada-C4/seemore/blob/fancyfeed/master/README.md).

A **feed** is an API that a web service uses to provide users with frequently updated content. A *feed aggregator*  is an application that acts as a central location for reviewing the content of feeds. It **injests** feeds and stores their content in its own datastore after transforming it into a standard format.

FancyFeed is a feed aggregator service that allows users to login via Twitter or Vimeo. Once logged in, a user can search for and subscribe to Vimeo and Twitter handles. FancyFeed pulls those handles' updates together into one aggregated feed on the homepage.

## Set Up

Get FancyFeed set up on your local computer:

1. Runs on ruby version 2.2.3
2. Fork our [repo](https://github.com/jennaplusplus/seemore/tree/fancyfeed/master), clone it to your local computer, and create your own branch to work from
3. Run ```bundle install```. If you get an error, try ```gem install bundle```, then ```bundle install``` again.
4. Run ```rake db:migrate``` to set up the database.
5. Run ```rails s``` then visit your local server to see the website.
6. We highly recommend you log in using OmniAuth's Developer Strategy, which is already configured. Instead of clicking the Twitter or Vimeo icons to log in, visit ```http://localhost:3000/auth/developer/```. This gives you a sample login from which you can play around. **NOTE:** this is **not** secure in any way and should never be used in deployment!
7. You can run the test suite by typing ```rspec```.

## Contribute!
We welcome contributions to FancyFeed! Bugs and enhancements are tracked as Github Issues.

 Comment on the issue you want to work on, then create a new branch for that feature or bug-fix. Please run ```rspec``` as you work, so we can ensure tests continue to pass, and test coverage remains above 95%.

When you're done, submit a pull request for us to review.
