# Movie App

## Real World Problem Identification

The primary real-world problem we aim to tackle is the inconvenience experienced by movie enthusiasts when trying to access and enjoy movies effortlessly. Currently, users often face the challenge of navigating complex interfaces and encountering overwhelming options while searching for movies that align with their preferences. This creates a need for a simplified movie app that streamlines the movie discovery and viewing process, making it user-friendly and accessible to a wide audience.

## Proposed Solution

Our proposed solution is to design and develop a user-friendly movie app that caters to the needs of movie enthusiasts by simplifying the process of finding and enjoying movies of their choice. This app will focus on providing a seamless and intuitive user experience, making movie discovery and playback straightforward and enjoyable.

To achieve this, we will implement the following key features:

1. **Login and Signup:**
   - Create a user-friendly authentication system with dedicated login and signup screens.
   - Ensure secure user registration and login processes, with data encryption for user data privacy and security.

2. **TMDB API Integration:**
   - Implement TMDB API integration to access a vast database of movies and retrieve essential movie information such as titles, genres, release years, synopses, cast, crew, and more.
   - Ensure seamless integration to provide users with a rich and up-to-date movie catalog.

3. **Search Feature:**
   - Develop a robust search functionality that enables users to easily find movies based on keywords, titles, genres, and other criteria.
   - Provide instant and relevant search results to enhance the user experience.

4. **Favorite Movie Feature:**
   - Allow users to mark movies as favorites or add them to a watch list for easy access later.
   - Create a user-friendly interface for managing and viewing their list of favorite movies.

## Responsive User Interfaces

## Mobile:

<div style="display: flex; flex-wrap: wrap;">
  <img src="https://github.com/ishabhutto/Flutter_Movie_App/assets/90207282/9b4159f7-7856-40ee-b00e-f08d8028998f" style="width: 200px; margin-right: 10px;">
  <img src="https://github.com/ishabhutto/Flutter_Movie_App/assets/90207282/17418279-d082-4014-8b31-ed5710f82fa8" style="width: 200px; margin-right: 10px;">
  <img src="https://github.com/ishabhutto/Flutter_Movie_App/assets/90207282/abe3ad68-25d7-42d7-8fa2-13a11f86653a" style="width: 200px; margin-right: 10px;">
  <img src="https://github.com/ishabhutto/Flutter_Movie_App/assets/90207282/86362032-8978-429d-8145-bf216e2997fb" style="width: 200px; margin-right: 10px;">
  <img src="https://github.com/ishabhutto/Flutter_Movie_App/assets/90207282/345efe6b-3cc1-423a-9d8a-dc1a65b2cf4a" style="width: 200px; margin-right: 10px;">
  <img src="https://github.com/ishabhutto/Flutter_Movie_App/assets/90207282/d462c9cf-238f-494e-958b-137f23e8a9b0" style="width: 200px; margin-right: 10px;">
  <img src="https://github.com/ishabhutto/Flutter_Movie_App/assets/90207282/aa555824-34fd-4b1b-8e02-05f263e03a7e" style="width: 200px;">
</div>

## Web:

<div style="display: flex; flex-wrap: wrap;">
  <img src="https://github.com/ishabhutto/Flutter_Movie_App/assets/90207282/c472352f-c3ea-4724-bbaa-0c5d3ce2d92c" style="width: 200px; margin-right: 10px;">
  <img src="https://github.com/ishabhutto/Flutter_Movie_App/assets/90207282/221c67f7-d9bd-4cdb-a593-52d0bf505e12" style="width: 200px; margin-right: 10px;">
  <img src="https://github.com/ishabhutto/Flutter_Movie_App/assets/90207282/0d07ae8a-da97-4b06-b563-7bb35a7e96ac" style="width: 200px;">
</div>

## Firebase:

<div style="display: flex; flex-wrap: wrap;">
  <img src="https://github.com/ishabhutto/Flutter_Movie_App/assets/90207282/f29fa447-98f8-49f5-b9e4-995f4bbf9265" style="width: 200px; margin-right: 10px;">
  <img src="https://github.com/ishabhutto/Flutter_Movie_App/assets/90207282/93597830-84e5-4dfd-a29b-6d7d3f846735" style="width: 200px; margin-right: 10px;">
  <img src="https://github.com/ishabhutto/Flutter_Movie_App/assets/90207282/bcbe46a2-960f-409c-bc1c-94909a07a055" style="width: 200px;">
</div>



## Firebase Data Storage
(With justification for using a particular database)

We have used Firebase for 2 purposes:

1. **Authentication:**
   - For authentication with email and password in login credentials and signup. Users can also update their password with the link if they click on "forgot password." The credentials will be updated automatically.

2. **Data Storage:**
   - We have implemented a database for saving information about favorite movies and retrieving and displaying information. Users can also delete items from their favorites. There are separate favorite lists for every user based on their UID.

## APIs/Packages/Plugins Used in the Movie App

In the development of our movie app, we have leveraged a variety of APIs, packages, and plugins to enhance functionality, streamline development, and provide a better user experience. Below is a list of the key APIs and packages we have integrated, along with justifications for their use:

1. **TMDB API (The Movie Database API):**
   - **Justification:** We have integrated the TMDB API to access an extensive movie database. This API provides us with a rich source of movie information, including details such as movie titles, genres, release years, synopses, cast and crew data, ratings, and images. By using this API, we ensure that our app offers users an up-to-date and comprehensive catalog of movies, enhancing the overall user experience.

2. **Authentication APIs (e.g., OAuth for Social Logins):**
   - **Justification:** We have incorporated authentication APIs, such as OAuth for social logins, to simplify the user onboarding process. This feature allows users to sign up or log in using their existing social media accounts, eliminating the need for them to create separate credentials. By doing so, we reduce friction during the registration process, leading to increased user adoption and a more seamless user experience.

3. **Firebase (Backend Services):**
   - **Justification:** Firebase is used for backend services, including real-time database management, user authentication, and cloud storage. Firebase's authentication services provide robust security, while cloud storage simplifies the handling of user-generated content such as documents collection.

**General Packages:**
- `firebase_auth`
- `cloud_firestore`
- `http`
- `firebase_core`
- `google_fonts`

## Issues and Bugs Encountered and Resolved during Development

**Issue 1: RenderCustomMultiChildLayoutBox object was given an infinite size during layout**

- **Resolution:** The error occurred because a widget inside the layout was trying to occupy an infinite height, and the parent widget did not provide any constraints to limit the height. To fix this issue, constraints were set to limit the height, ensuring that the layout could be rendered correctly.
- ![image](https://github.com/ishabhutto/Flutter_Movie_App/assets/90207282/9d583929-b632-4f05-81c8-bd95630df158)
- ![image](https://github.com/ishabhutto/Flutter_Movie_App/assets/90207282/3d06f744-6c23-4031-905c-8d691be03711)
- ![image](https://github.com/ishabhutto/Flutter_Movie_App/assets/90207282/494f3316-3408-434d-ab3a-ec1bc4d4b4ef)

**Issue 2: _TypeError (type 'int' is not a subtype of type 'double?')**

- **Resolution:** This error occurred due to a type mismatch in the data received from APIs. The `vote_average` field in the JSON response was of type double, but the Movie class defined it as double?, a nullable double. To resolve this issue, the Movie class was updated to define the vote field as type double.
- ![image](https://github.com/ishabhutto/Flutter_Movie_App/assets/90207282/30e01031-bd9e-4de6-83da-feeefd7f0f6d)
- ![image](https://github.com/ishabhutto/Flutter_Movie_App/assets/90207282/8fe61413-a974-4045-9b11-d6403883f557)

**Issue 3: Firebase Access Issue**

- **Resolution:** An access issue occurred when connecting Firebase to the movie app and selecting functionalities. The problem was related to the rules in Firebase, where read and write access was not granted. The rules were updated to allow the required access, resolving the issue.
- ![image](https://github.com/ishabhutto/Flutter_Movie_App/assets/90207282/54404d51-e02d-412d-9c6a-605dc6d99d9f)
- ![image](https://github.com/ishabhutto/Flutter_Movie_App/assets/90207282/94efaee6-db61-40aa-9fa4-8a89a618b68b)

**Issue 4: User Data Storage with Firebase**

- **Resolution:** Initially, user data storage for favorites was problematic, as all users were getting the same favorite collection. The solution was to integrate unique user identification from Firebase with each user's collection, ensuring that each user's data was stored separately. The same approach was used for retrieving and deleting favorites.
![image](https://github.com/ishabhutto/Flutter_Movie_App/assets/90207282/fe0f317b-d085-4d43-a6f4-a141905208d5)
![image](https://github.com/ishabhutto/Flutter_Movie_App/assets/90207282/862f5c8b-1830-456b-9ebe-32c709da302f)
![image](https://github.com/ishabhutto/Flutter_Movie_App/assets/90207282/f9cc349a-feeb-431a-8f24-d0e8fd53552d)

