# Level 1
https://jsonplaceholder.typicode.com/users returns a list of every user,
10 entries, to be specific.
Each entry has "id", "name", "username", "email", "address" 
(that nests "street", "suite", "city", "zipcode", and "geo" 
(which also nests "lat" and "lng)), "phone", "website", and 
"company" (which nests "name", "catchPhrase", and "bs").

https://jsonplaceholder.typicode.com/users/999 with GET returns a
response of status 404 "Not Found", because this record doesn't exist
in the list.

When POST to https://jsonplaceholder.typicode.com/users, the
server doesn't actually require anything, and returns a successful response
of status 201 "Created" with the following body: "{id: 11}".

# Level 5
A request sent from wifi with no internet connection gets a
timeout after 10 seconds, because it was specified so in the ApiClient.
