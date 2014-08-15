---
layout: post
title: Getting Started With Ruby on Rails Application Development
---

In the world of Ruby on Rails application development, there can be a lot to learn. All of the wonderful tools and terminology that are second-nature to an experienced Rails developer appear as a sea of jargon to the new-comer. In this post, I would like to offer you a "self guided tutorial" which should help you to become familiar with many of the things that Rails developers use every day.

## Prerequisites

I'm going to assume that you have a basic understanding of Ruby syntax and have gone through the work of installing Ruby on your computer. If not, you will need to do that first. I recommend installing [rbenv](https://github.com/sstephenson/rbenv). I'm also going to assume that you've started reading [the Rails Guides](http://guides.rubyonrails.org/getting_started.html). I think this is the best place to get started learning Rails.

What you will need to learn:

* How to install software using the command line
* How to install packages specific to your operating system
* The general layout of a Rails application
* Some basic Rails concepts: Models, Views, Controllers

## Step 1: Find an open-source Rails project

Any project will do. Here's [one example](https://github.com/ruby-rcade/RubyGameDev.com).

What you will need to learn:

* How to search the web and discover open source projects
* How to know if an open source project was written in Rails

## Step 2: Clone the repository

Every Ruby project that I know of is hosted on GitHub and uses Git for version control. Get this repository onto your computer by cloning it.

What you will need to learn:

* How to use Git and GitHub
* Why version control is important

## Step 3: Install the project's dependencies

Rails is one of many dependencies required to run a Rails project. Most Ruby applications are built on top of many other open source projects.

What you will need to learn:

* How to install Ruby Gems
* How to use Bundler
* Where dependencies are defined in a Rails project

## Step 4: Figure out how to run the application locally

Running the application locally will be a common task.

What you will need to learn:

* How to use the Rails command line tool
* Learn how to start the server
* Learn how to stop the server

## Step 4: Figure out how to run the test suite

Any Rails project worth its salt has a test suite. Ruby developers are generally pretty good about writing automated tests for their code. There could be many types of tests in a Rails project (unit, integration, etc). There could be many different testing libraries used within the project (RSpec, MiniTest, Cucumber, etc).

What you will need to learn:

* Which testing frameworks are being used on this project
* What is the difference between unit and integration tests
* How to run project specific command line tasks with Rake
* Where test code lives within the directory structure

## Step 5: Determine the status of the test suite

If the test suite is passing, you know things are stable. If the test suite is failing, you know there is work that needs to be done to get the test suite passing again, before you can be assured that you are not breaking things when you add new code.

What you will need to learn:

* How to determine if the tests are passing or failing
* Which Continuous Integration service is being used

## Step 6: Determine the coverage of the test suite

The presence of a test suite does guarantee that the tests adequately cover every part of the application. If the coverage is below 90% in any particular area, you know there is work that needs to be done.

What you will need to learn:

* How to determine code coverage

## Step 7: Find a bug to fix, or a feature to contribute

Start by checking the project's issue tracker. Create a branch and submit a pull request.

What you will need to learn:

* How to create a branch in Git
* How to fork a repository in GitHub
* How to create and submit a pull request in GitHub

