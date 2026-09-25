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

Session 4 — Tags and Search/Browse

Driver: Darsh Tulsiyan  
Navigator: Bhagavatiraj Yadav

Work completed:
Implemented tags using Tag and PostTag.
Displayed tags alongside posts.
Added keyword-based post search.
Added a search form and no-results message.

Notes:
Discussed many-to-many relationships.
Reviewed ActiveRecord search queries.
Tested empty searches and searches with no matches.
Switched roles and reviewed the functionality.

Session 5 — Post Editing and Deletion

Driver: Darsh Tulsiyan  
Navigator: Bhagavatiraj Yadav

Work completed:
Implemented post editing and updating.
Added post deletion functionality.
Added edit and delete controls.
Added a confirmation dialog before deletion.
Added validation for invalid updates.

Notes:
Reviewed Rails RESTful routes.
Discussed reusing forms for creating and editing posts.
Debugged Rails form-helper issues.
Switched roles and tested the functionality.

Session 6 — Related Posts

Driver: Bhagavatiraj Yadav  
Navigator: Darsh Tulsiyan

Work completed:
Implemented related posts using shared tags.
Excluded the current post from recommendations.
Displayed related posts on the individual post page.
Added request tests for related-post functionality.

Notes:
Discussed using existing tag relationships.
Reviewed ActiveRecord joins.
Tested matching posts, unrelated posts, and no matches.
Switched roles and reviewed the tests.

Session 7 — Popular Posts

Driver: Darsh Tulsiyan  
Navigator: Bhagavatiraj Yadav

Work completed:
Implemented sorting posts by upvote count.
Added Newest and Most Upvoted sorting options.
Integrated sorting with search.
Included posts with zero upvotes.

Notes:
Discussed calculating upvote counts using associated records.
Debugged the missing upvotes_count database column error.
Reviewed ActiveRecord joins and SQL aggregation.
Switched roles and tested the sorting functionality.

Session 8 — Testing and Final Integration

Driver: Bhagavatiraj Yadav  
Navigator: Darsh Tulsiyan

Work completed:
Added and reviewed RSpec model and request tests.
Tested user and post management.
Tested search and related posts.
Reviewed validation and sad-path test cases.
Integrated features and updated documentation.

Notes:
Discussed testing successful and unsuccessful operations.
Reviewed request tests and HTTP responses.
Used SimpleCov to review test coverage.
Switched roles and reviewed the application together.
