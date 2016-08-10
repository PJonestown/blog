## Introduction

This is my blog. There are many like it but this one is mine.

Joking aside, this was my first non-tutorial rails app.

I gained a better understanding of reading documentation, solving problems the rails way, and a familiarity with CRUD and MVC architecture.

## Configuration

* Download or clone the repo
* [Create a Postgres role for the database](https://www.digitalocean.com/community/tutorials/how-to-setup-ruby-on-rails-with-postgres)
* Run `bundle install`
* Run `rake db:migrate`
* Run `rails server`
* Head over to http://localhost:3000/

## Some cool features

* Devise authentication
* Custom authorization
* Omniauth login for commenters
* Polymorphic comments
* Ajax for comment creation and deletion
* Markdown with Redcarpet
* Custom draft logic
* Integration tests with RSpec and Capybara

## What I learned

#### Everything

Everything? What a vague, silly header!

But it's the best I can come up with! Git, github, routes, controllers, models, views, erb, REST, CRUD, polymorphism, and every gem was learned for the first time.

Everything in this app was a stumbling block and a new concept.

#### Ruby on Rails is actually fun!

Working through tutorials was a grind.

Working on my own project, solving my own problems, and making my own mistakes made programming an adventure.

After I finished up this app I felt an immense sense of freedom and possibility.

## Room for improvement

#### Using code I didn't understand

I wanted OAuth login for commenters that allowed for authentication through both twitter and gmail.

Two major problems resulted from this choice.

* Twitter does not require an email address which requires a difficult extra
step

* I wanted accounts associated with different OAuth providers with the same
email to be linked

I used the following guide to try to navigate through these problems

http://sourcey.com/rails-4-omniauth-using-devise-with-twitter-facebook-and-linkedin/

But the concepts were beyond my ability at the time. I shouldn't have been so stubborn and used a simpler authentication solution for commenters which I completely understood.

#### No unit tests

I chose to only use integration tests with Capybara for this app.

At the time everything was new and difficult. Being able to focus just on getting the app to work with some very basic testing was a big enough accomplishment at the time.

This had trade-offs. My tests are very slow, and I was forced to test a lot of edge cases through Capybara.

Definitely not ideal.

#### Messy code

While I was creating this app, all I cared about was getting it to work.

I never bothered to re-factor. I often didn't even bother to delete commented out sections of code from previous solutions. Improper indentation, extra lines, and repeated code plague this app.

I rationalized that I'd take care of it later, but I quickly learned just how fast things can get out of hand.

 ## License

 The MIT License (MIT)
Copyright (c) 2016 Paul Johnston

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
