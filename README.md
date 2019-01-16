# README

* Anagram API
  This API is seeded with all of the words from the English dictionary. You can use it to quickly find all of a word's anagrams. This is a Rails API that uses a postgresql database.

* Ruby version
  2.3.3

* Rails version
    5.2.2

* Configuration
  These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

  # Installing
  First fork and clone a copy of the repository
  ```
  git clone (link)
  ```

  Once cloned, cd into the ibotta-api repo
  ```
  git cd ibotta-api
  ```

  Then bundle install to install any gems and/or dependencies
  ```
  bundle install
  ```

  Run the rails server and head to http://localhost:3000 in the browser
  ```
  rake db:migrate && db:seed
  ```

* How to run the test suite
  To run unit tests on the Word model
  ```
  ruby test/models/word_test.rb
  ```

  For integration tests :
  ```
  ruby test/anagram_test.rb
  ```

* Endpoints in the browser

   To see a specific word (where :letters is the word you want to see)
   ```
   /words/:letters
   ```

   Find the anagrams of a given word:
   ```
   /anagrams/:letters
   ```

   Find only a specified amount of anagrams for a word:
   ```
   #change out '1' with the amount of anagrams you would like to see

   /anagrams/:letters?limit=1
   ```

   Find total word count max/min/avgerage wor length:
  ```
  /dictionary_stats
  ```

* Terminal usage  
    To add a word:
     ```
     curl -X POST -d '{ "words": ["read", "dear", "dare"] }' -H 'Content-Type: application/json' http://localhost:3000/words.json
     ```

    Fetch anagrams:

    ```
    curl -i http://localhost:3000/anagrams/read.json
    ```

    Fetch specific number of anagrams;

    ```
    curl -i http://localhost:3000/anagrams/read.json?limit=1
    ```

    Delete single word:
    ```
    curl -i -X DELETE http://localhost:3000/words/read.json
    ```

    Delete all words:
    ```
    curl -i -X DELETE http://localhost:3000/words.json
    ```

* Current Features/Limitations/Optional Feature Adds

  - Upon instantiation of a word, it is added to the dictionary hash. This hash table stores words based on a key of the word's sorted letters. All anagrams of that word are stored in a an array under that hash key for quick lookup.   
  - If a user tries to find a word that is not yet in the database, it will automatically be created and if it has any anagrams, they will show up when requested.
  - If a user tries to find a number or symbol, it will return a message to let them know they can only search words
  - Add a uniqueness validation to the Word Model so a word cannot be added twice. The way anagram_test.rb (test_adding_words) is set up currently won't allow for this, but if that test is taken out the validation can be commented back in to use.
  - I purposefully excluded true index page that displays all of the words because with a full library (200,000+ words), it takes a very long time to load.



  ## Built With

  * [Ruby on Rails](https://rubyonrails.org/)
  * [postgresql](https://www.postgresql.org/) - Database management

  ## Contributing

  Please read [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) for details on our code of conduct, and the process for submitting pull requests to us.

  ## Authors

  * **Savannah Younts** - *Initial work* - [Sav Younts](https://github.com/savyounts)
