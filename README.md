G-Chart           
                                                                                                                                                                                                        
                                                                                                                      
#
# Suite
1. Web – Vue 
1. Mobile – Android – Flutter  
1. Mobile – IOS – Swift  
1. Database – Redis  
1. API – GO 
# REST API Structure
- CRUD 
- Cache
## Structure	

|**Data Type**|**Description**|**Request**|**Response**|**Data tables**|**Other Info**|
| :- | :- | :- | :- | :- | :- |
|**ListType**|Create a new list|Post {UserID,Name,…}|200 OK|ListType||
|**ListType**|Edit a new list|PUT:id { Name,…}|200 OK|ListType||
|**ListType**|Delete a new list|Delete:id|200 OK|ListType||
|**ListType**|Get all for User|Get:id|{}|ListType||
|**ListType**|Get all for Filter|<p>Get:…filters</p><p></p>|[{}]|ListType||
|**List**|Create a new list|Post {ListID, UserID, Name,…}|200 OK|List||
|**List**|Edit a new list|PUT:id { isTemplate,…}|200 OK|List||
|**List**|Delete a new list|Delete:id|200 OK|List||
|**List**|Get all for User|Get:id|{}|List||
|**List**|Get all for Filter|<p>Get:…filters</p><p></p>|[{}]|List||

# Database Structure

![QuickDBD-export](https://user-images.githubusercontent.com/49421043/199138536-e554cfaf-6381-4d02-9ac3-22f705bda02f.svg)

# Mock-up 
## Main Pages: 
- Home
  - Calendar (list similar to google notes) 
    - Subpage: workout
- Search
1. Search Bar
1. Link to favorites
- History
  - Calendar that displays completed workouts
  - Exercise weight/reps progression chart (with graph generated for each)
  - Export data as CSV
  - Post to Reddit
- Social
  - My profile (name, avatar, bio)
  - Horizontal feed 
  - My progression (photos, weight, link to history)
  - Friends (if you send a request, they are displayed on yours. If you accept, they are displayed on yours)

  - My workouts
## Sub-pages:
- Workouts 
  - List similar to google keep
  - “Add” button with the ability to search a categorized list of exercises
  - Each entry can be input by “name <# of sets>x<# of reps>(x<weight>)”
    - Name of the exercise gets autogenerated (grayed out)
    - Number of sets and reps get predicted on past data
    - Clicking on the name lets edit the whole line. Clicking on number lets change only that number.
    - Search icon lets search by category






