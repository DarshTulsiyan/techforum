Pairing Log

Session 1 — Project Setup and User/Post Management

Driver: Darsh Tulsiyan
Navigator: Bhagavatiraj Yadav

Work completed:

Set up the Rails project structure.

Implemented the initial user functionality.

Implemented the initial post functionality.

Discussed the models, controllers, views, and routes used by the application.

Notes:

Discussed how the Rails MVC structure would be used for TechForum.

Reviewed the relationship between users and posts.

Switched driver/navigator roles during the session to make sure both team members understood the implementation.


Session 2 — Comments and Replies

Driver: Bhagavatiraj Yadav

Navigator: Darsh Tulsiyan

Work completed:

Implemented comments on posts.

Added the relationship between posts, comments, and users.

Added support for replying to existing comments.

Updated the post page to display comments and replies.

Added the nested comment route and controller handling.

Notes:

Discussed using a self-referential relationship for comment replies.

Reviewed how `parent_id` connects a reply to its parent comment.

Discussed the flow from the post page to the nested comments controller.

Switched driver/navigator roles during implementation and reviewed the completed code together.


Session 3 — Post Upvotes

Driver: Bhagavatiraj Yadav

Navigator: Darsh Tulsiyan

Work completed:

Implemented post upvoting.

Added the `PostUpvote` model functionality.

Added the upvote count to posts.

Prevented a user from upvoting the same post more than once.

Added a database-level unique index for post/user upvotes.

Notes:

Discussed why duplicate-upvote prevention should be handled both in the Rails model and database.

Reviewed the request flow from the upvote button to the controller and model.

Discussed the difference between application-level validation and database constraints.

Switched driver/navigator roles and reviewed the implementation together.
