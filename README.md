# Effective-Testing-with-RSpec-3

Code developed when we read the book:

Title:   EffectiveTesting with RSpec 3
         Build Ruby Apps with Confidence

Authors: Myron Marston and Ian Dees

ISBN:    978-1-68050-198-8

-------------------------------------------
Setup

1. Install asdf to manage ruby versions (ruby 2.7.2)

2. Install bundler:

> gem install bundler

3.

> bundle install

> (bundle install --redownload)

4. Create DBs

> bundle exec sequel -m ./db/migrations sqlite://db/development.db --echo

> bundle exec sequel -m ./db/migrations sqlite://db/test.db --echo
