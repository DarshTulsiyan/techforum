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

## 6. Search and Browse Posts

**User Story:**
As a user, I want to search and browse posts using keywords so that I can quickly find relevant technical discussions.

**Acceptance Criteria:**

* All posts are displayed when no search keyword is entered.
* A user can search posts using keywords.
* Search matches the post's title, body, or category.
* Only matching posts are displayed after searching.
* If no posts match the keyword, a message is displayed.
* A user can clear the search to view all posts again.

## 7. Post Editing and Deletion

**User Story:**
As a user, I want to edit or delete an existing post so that I can correct information or remove content that I don't want.

**Acceptance Criteria:**
* A user can edit an existing post's title, body, and category.
* Valid changes are saved and displayed on the updated post.
* An updated post must still contain a title and body.
* Invalid updates should not be saved.
* A user can delete an existing post.
* A confirmation dialog is displayed before deletion.
* After deletion, the user is redirected to the posts page.

## 8. Organizing Posts with Tags

**User Story:**
As a user, I want to add tags to my posts so that other users can easily identify and discover discussions related to specific technical topics.

**Acceptance Criteria:**
* A user can enter tags while creating a post.
* Tags are associated with the correct post.
* Tags are displayed alongside the post.
* Existing tags can be reused across multiple posts.
* A user can search for posts using tag names.
* A post can have multiple tags.

## 9. Popular Posts

**User Story:**
As a user, I want to sort posts by their upvote count so that I can discover discussions that other users have found useful.

**Acceptance Criteria:**
* A user can select the "Most Upvoted" sorting option.
* Posts are displayed in descending order of upvote count.
* Posts with zero upvotes are still displayed.
* Posts with equal upvote counts are ordered by creation date, with newer posts first.
* A user can switch back to the default "Newest" sorting option.
* Search and sorting can be used together.
* The displayed upvote count matches the number of upvotes associated with each post.