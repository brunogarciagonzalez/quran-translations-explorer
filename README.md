# Quran Translations Explorer

I hope to build a multi-faceted app, which includes at least the following features:

### Translations Comparer

Via the TranslationsController:
* Showcase diferent translations of Quran, and switch between translations easily.
* Compare different translations of a specific verse.

### Quranic Verse Finder

Via the QueriesController:
* Serve as a search engine for translations in english of the Quran.
* Different search types will have respective controller actions. 
  * Build for single word queries, exact phrase queries, and others.
  * Choose what translations to search through, starting with English.
  
### Personal Study Space

Authentication via safe password storage (Bcrypt: password hashing function) & Authorization via JSON Web Tokens (JWT):
* Allow users to log in and store information related to their studies (being purposefully ambiguous, many things planned and am hopeful to make them happen)
