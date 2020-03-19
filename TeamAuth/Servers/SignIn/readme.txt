Directory for the TeamAuth signin server.

Description:
The server should take a users request to sign in to class for attendence and provide a response,
as well as update a central user database noting the current status of the user's authentication.

Inputs:
1. Photo of user's face
2. Special access key from nfc tag
3. Context (e.g. user id, class id) 

Outputs:
1. Successful uniqueness identification
2. Successful location identification

Features:
- Receive photo
- Compare photo to user's feature data
- Receive secret key
- Compare secret key to class's current secret key

Files:
- signin_server.py
	- Server that orchestrates all features

Changelog

3/17/20


3/16/20
- Currently accepts photos from any source that connects to the server
