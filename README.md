#Music Inventory Manager
This build is for a home music inventory management program. This system is a tool that anyone can use. It helps you keep track of all of your music with artist and album information, but also what kind of media type it is and where it is located in your home. 

##Description
Here are the different things that we have:

Some number of music items (bands, solo artist, soundtracks)
Some number of media types (CD, MP3, cassette, etc.)
Some number of locations (bookshelf, CD tower, record box 1, etc.)

Each music item has a media type and a location. Each location and media type have multiple music items. 

The task is to build a database-driven web application to help manage this music inventory manager. 

### "Should" cases
Should be able to do:

-Create, read, update and delete music items

-Create, read, delete locations

-Create, read, delete media types

-Assign music items to a location (a given location should be able to hold multiple music items)

-Assign music items to a media type (a given media type should be able to hold multiple music items)

-Fetch all music items in a given location

-Fetch all music items in a given media type

-Search for music items by band name

-Search for music items by album name


### "Should not" cases
What we should not be able to do:

-Create a music items without a band name and a location

-Delete a location without first checking that there are no music items assigned to it

-Delete a media type without first checking that there are no music items assigned to it


