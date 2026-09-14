## 1. User Creation

**User Story:**
As a new user, I want to create a profile with a username and email so that I can participate in the TechForum community.

**Acceptance Criteria:**

* A user can enter a username and email.
* A new user record is created when valid information is submitted.
* The user is redirected to the users page after successful creation.
* Invalid user information should not create a user.

## 2. Post Creation
**User Story:**
As a user, I want to create a post with a title, body, category, and tags so that I can share my ideas on the forum.

**Acceptance Criteria:**

* User has to exist to create the post.
* The post must contain both a title and a body.
* The post is associated with the user who created it.
* After successful creation, the user is redirected to the new post.
* A post with an empty title or body is not created.
* If the username does not exist, the post is not created and an error is shown.

## 3. Upvoting Posts

**User Story:**
As a user, I want to upvote a post so that I can show that I like the post and find it useful.
**Acceptance Criteria:**

* A user can upvote an existing post.
* The post's upvote count increases after a successful upvote.
* The upvote is associated with both the user and the post.
* The updated upvote count is visible on the post.
* The same user cannot upvote the post more than once.

## 4. Commenting on Posts
**User Story:**
As a user, I want to comment on a post so that I can add my thoughts to the discussion.

**Acceptance Criteria:**

* A user can submit a comment on an existing post.
* The comment is associated with the correct post.
* The comment is associated with the user who submitted it.
* The new comment appears under the post after it is successfully created.
* An invalid comment should not be saved.


## 5. Replying to Comments

**User Story:**
As a user, I want to reply to another user's comment so that I can respond directly to a specific part of the discussion.

**Acceptance Criteria:**

* A user can reply to an existing comment.
* The reply is associated with the original parent comment.
* The reply is associated with the user who created it.
* The reply is displayed under the comment it responds to.
* If the parent comment does not exist, the reply should not be created.
