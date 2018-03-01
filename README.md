### Therapy Track

[![CircleCI](https://circleci.com/gh/anlewis/therapy_track.svg?style=shield)](https://circleci.com/gh/anlewis/therapy_track)

TherapyTrack is an application for people with anxiety/depression that synthesizes user information in a single page report and remind users to schedule therapy appointments.

#### Background

TherapyTrack has 2 main goals:

1. Provide appointment reminders for users so that they get to therapy
2. Generate a wellness report that will help them answer screening questions and more accurately reflect on their wellbeing over the last 2 weeks, 30 days, or 3 months

Anxiety disorders are the most common mental illness in the U.S., affecting 40 million adults in the United States, or 18.1% of the population every year. Anxiety disorders are often coupled with depressive disorders, such as major depressive disorder which affects about 6.7% of U.S. adults. However only 36.9% people affected by anxiety and 61.7% of those affected by depression receive treatment. The goal of this application is to allow users a way to synthesize information on their wellness and receive appointment reminders so that therapy appointments will be easier and less intimidating to attend. 

#### Getting Started

This project uses the Ruby on Rails framework, which can be installed from [here](http://installrails.com/).
[Bundler](http://bundler.io/) is used to install the gems needed for this application.

In order to run this appication in the development environment, perform the following in the CLI:

```
bundle install
rake db:create db:migrate
```

In order to spin-up the server, run: `rails s`

#### Testing

[Rspec-Rails](https://github.com/rspec/rspec-rails) is used for testing.
[Factory_Bot](https://github.com/thoughtbot/factory_bot) is used to create test data.

In order to run tests, perform the following:

`rake db:test:prepare`

`rspec`

#### Linting

Linting is done by [Rubocop](http://rubocop.readthedocs.io/en/latest/).

From within the project folder, run `rubocop` to check files.

#### References

OAuth 2.0 for Google setup through [Rich on Rails](https://richonrails.com/articles/google-authentication-in-ruby-on-rails/)

Google Calendar API setup following the guide [ReadySteadyCode](https://readysteadycode.com/howto-integrate-google-calendar-with-rails)

For stub_omniauth and testing [Jesse Spevack](http://www.jessespevack.com/blog/2016/10/16/how-to-test-drive-omniauth-google-oauth2-for-your-rails-app)

Advice on Psychology Assessments give by [Elena Kronmiller](https://www.linkedin.com/in/elena-kronmiller-a91679121/)
