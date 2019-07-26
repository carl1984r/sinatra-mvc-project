# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app
  - True
- [x] Use ActiveRecord for storing information in a database
  - True
- [x] Include more than one model class (e.g. User, Post, Category)
  - Models include User, Review and Airport.
- [x] Include at least one has_many relationship on your User model (e.g. User has_many Posts)
  - User has_many :airports and has_many :reviews, through: :airports
  - Airport has_many :reviews
- [x] Include at least one belongs_to relationship on another model (e.g. Post belongs_to User)
  - Review belongs_to :airport
  - Airport belongs_to :user
- [x] Include user accounts with unique login attribute (username or email)
  - username
- [x] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying
  - True
- [x] Ensure that users can't modify content created by other users
  - True
- [x] Include user input validations
  - True
- [x] BONUS - not required - Display validation failures to user with error message (example form URL e.g. /posts/new)
  - True
- [x] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code
  - True
Confirm
- [x] You have a large number of small Git commits
  - True
- [x] Your commit messages are meaningful
  - True
- [x] You made the changes in a commit that relate to the commit message
  - True
- [x] You don't include changes in a commit that aren't related to the commit message
  - True
