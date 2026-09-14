# README

## TECHFORUM

Techforum is an application that allows user to create posts, participate in discussions through comments and replies, and upvote posts they like and find useful. The application provides a simple platform for users to share technical questions, ideas, and information.

## Main Features

* create users with username and email id
* create posts with title, body, category and tags
* Associate posts with their authors.
* View posts and their details.
* Upvote posts.
* Add comments to posts.
* Reply to existing comments.
* Validation and error handling for invalid data entries.

## Requirements

* Ruby
* Ruby on Rails
* Bundler
* SQLite3

## Installation and Setup

### 1. Clone the repository

```bash
git clone https://github.com/DarshTulsiyan/techforum.git
cd techforum
```

### 2. Install dependencies

```bash
bundle install
```

### 3. Set up the database

Create the database and run all migrations:

```bash
bin/rails db:prepare
```

Alternatively:

```bash
bin/rails db:create
bin/rails db:migrate
```

## Running the Application

Start the Rails development server:

```bash
bin/rails server
```

Then open the following address in a web browser:

```text
http://localhost:3000
```

Press `Ctrl+C` in the terminal to stop the server.

## Running Tests

The project uses RSpec for automated testing.

Run the complete test suite with:

```bash
bundle exec rspec
```

To run a specific test file:

```bash
bundle exec rspec spec/models/post_spec.rb
```

For example, request specs can be run using:

```bash
bundle exec rspec spec/requests/posts_spec.rb
bundle exec rspec spec/requests/users_spec.rb
```

## Test Coverage

The project uses SimpleCov to generate a test coverage report.

Run:

```bash
bundle exec rspec
```

After the tests finish, SimpleCov generates the coverage report in:

```text
coverage/index.html
```

Open `coverage/index.html` in a web browser to view the detailed coverage report.

## Project Structure

Important directories include:

```text
app/models/          Database models and relationships
app/controllers/     Request handling and application logic
app/views/           User interface templates
config/routes.rb     Application routes
db/                  Database migrations and schema
spec/                RSpec automated tests
docs/                Project documentation and user stories
```

## Known Limitations

* The application uses a username to identify a user when creating content rather than a complete authentication/login system.
* User authentication and password management are not currently implemented.
* The application is intended as a small course project and does not currently include production-level authorization or security features.
* Upvoting and discussion functionality are intentionally kept simple.
* Some invalid-input cases may require additional validation as the application is expanded.


## Team Members

* Darsh Tulsiyan
* Bhagavatiraj Yadav
