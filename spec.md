
Specs:
- [x] Use Sinatra to build the app: 
        Used sinatra & sinatra-flash for messages
- [x] Use ActiveRecord for storing information in a database
        Used ActiveRecord for migrations and for models
- [x] Include more than one model class: 
        Model classes are: author, book, book_author, book_genre, genre, user
- [x] Include at least one has_many relationship (x has_many y e.g. User has_many Posts)
        Genre, author, book & user models all include has_many relationships
- [x] Include user accounts
        Users are required to create an account and log in, all data is displayed based on user id (session id)
- [x] Ensure that users can't modify content created by other users
        Edit, update, and delete actions validate user
- [x] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying
        Book objects can be created, book details can be shown, book objects can be updated by their user, and can be destroyed by their user.
- [x] Include user input validations
        User can add book that another user has in their collection without conflict, but cannot add genre or author that already exists
- [x] Display validation failures to user with error message (example form URL e.g. /posts/new)
        Flash message is shown if user tries to add book that is already in their collection. Failure page is shown if user attempts to log in with incorrect credentials.
- [x] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code

Confirm
- [x] You have a large number of small Git commits
- [x] Your commit messages are meaningful
- [x] You made the changes in a commit that relate to the commit message
- [x] You don't include changes in a commit that aren't related to the commit message