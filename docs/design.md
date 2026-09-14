# TechForum Design Document

## 1. System Overview

TechForum is a Ruby on Rails discussion forum where users can create posts, comment and reply to discussions, and upvote posts.

The application follows the standard **Model-View-Controller (MVC)** architecture.

```text
User
  |
  v
Views
  |
  v
Controllers
  |
  v
Models
  |
  v
Database
```

* **Models** manage application data, relationships, and validations.
* **Views** display pages, forms, posts, and comments to users.
* **Controllers** process user requests and interact with the models.
* **Database** stores users, posts, comments, tags, and upvotes.

## 2. Main Models

### User

Represents a TechForum user. A user has a username and email and can create posts, comments, replies, and upvotes.

### Post

Represents a discussion post. Each post belongs to a user and contains a title, body, category, and optional tags. Posts can receive comments and upvotes.

### Comment

Represents a comment made on a post. Comments belong to users and posts. A comment can also have replies, allowing simple threaded discussions.

### PostUpvote

Connects a user with a post they have upvoted. Using a separate model allows the application to track who upvoted each post.

### Tag / PostTag

Tags categorize posts. `PostTag` creates a many-to-many relationship between posts and tags.

## 3. User Interface and Workflows

The interface provides simple forms and pages for interacting with the forum.

### Creating a User

```text
Enter Username & Email
        |
        v
   Submit Form
        |
        v
   User Created
```

### Creating a Post

```text
Enter Username, Title, Body,
Category and Tags
        |
        v
   Submit Post
        |
        v
Validate User and Post
        |
     +--+--+
     |     |
   Valid  Invalid
     |     |
     v     v
Save Post  Show Error
```

Posts with an empty title or body are rejected. A post is also rejected if the provided username does not exist.

### Comments and Replies

Users can open a post, add a comment, and reply to existing comments. Replies are displayed with their parent comments to make discussions easier to follow.

### Upvotes

Users can upvote posts they find useful or interesting. The number of upvotes is displayed with the post.

## 4. Important Design Decisions

**Ruby on Rails MVC:** Rails was chosen because its MVC structure clearly separates the user interface, application logic, and database operations.

**Model Validations:** Important validation rules, such as requiring a post title and body, are implemented in the model so invalid records cannot be saved.

**Separate Upvote Model:** Upvotes are stored separately instead of only keeping an integer count. This allows an upvote to be associated with both a user and a post.

**Username-Based Identification:** The current application uses usernames to identify users when creating content. This keeps the project simple but does not provide full authentication.

## 5. Current Limitations

The application is designed as a small course project. It currently does not include a complete login/authentication system, advanced authorization, or complex discussion features. These could be added in future versions.
