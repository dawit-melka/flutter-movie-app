# Movie App

The Movie App is a mobile application designed to provide users with easy access to a vast database of movies. Users can search for movies based on categories, titles, or content, and view detailed information about each movie. Additionally, users can save their favorite movies for later viewing. This README will guide you through the app's features, architecture, and how to set up the project.
<img src="https://github.com/RealEskalate/2023-project-phase-assessment/assets/105089130/7e0f5097-b458-4eca-8746-de7b7e411a27"  width="200" height="400"/> <img src="https://github.com/RealEskalate/2023-project-phase-assessment/assets/105089130/2a269724-d3d9-4c20-bcec-c0dd102b4a97"  width="200" height="400"/> <img src="https://github.com/RealEskalate/2023-project-phase-assessment/assets/105089130/4a69f26f-0d3d-41ee-af9e-bb0e22a3b79d"  width="200" height="400"/> <img src="https://github.com/RealEskalate/2023-project-phase-assessment/assets/105089130/c6b733f0-5151-4dfc-8777-22595dd9c8cf" width="200" height="400"/>


## Features

### Onboarding Page

The Onboarding Page is the initial screen that users encounter when they first open the app. Its purpose is to introduce users to the app's functionality and guide them through its features and navigation.

### Home Page

The Home Page serves as the central hub of the app, offering the following features:

#### Search Movies

- Users can input search queries into a search text field.
- They can search for movies by categories, titles, or content.
- Upon entering a query and hitting the search button, users will be presented with a list of movies that match their search criteria.

#### Saved Movies

- This section allows users to bookmark or save movies they are interested in for later viewing or reference.
- Users can easily keep track of their favorite films in this section.

#### All Movies in Cinema

- Users can explore a comprehensive list of all available movies in the app's database.
- These movies can be sorted by various filters, such as release date, genre, or popularity, to make the selection process more user-friendly.

### Movie Detail Page

When a user selects a specific movie from the search results or the list of all movies, they are taken to the Movie Detail Page. Here, users can access in-depth information about the selected film, including:

- Title
- Category
- Description
- Duration
- Image or poster
- User ratings

Users can read more about the movie, view its poster or cover image, and see its average rating from other users.

## API Integration

The Movie App integrates with a movie database API to fetch movie information. Here are the API endpoints used in the app:

- **Get All Movies:** `https://film-db.onrender.com/api/v1/article`
  - This endpoint retrieves a list of all movies available in the app's database.

- **Search Movies:** `https://film-db.onrender.com/api/v1/article?searchParams=Quest`
  - Users can search for movies by providing search parameters, such as keywords or titles.

- **Movie Detail:** `https://film-db.onrender.com/api/v1/article/64f61804c4ee2805e925b7cd`
  - This endpoint retrieves detailed information about a specific movie based on its unique identifier.

## Getting Started

To set up and run the Movie App on your local development environment, follow these steps:

1. Clone the repository to your local machine:

   ```bash
    https://github.com/dawit-melka/flutter-movie-app.git
   ```

2. Navigate to the project directory:

   ```bash
   cd flutter-movie-app
   ```

3. Install the required dependencies:

   ```bash
   flutter pub get
   ```

4. Start the app:

   ```bash
   flutter run
   ```

Make sure you have Flutter and Dart installed on your system before running the app.

## Dependencies

The Movie App utilizes several third-party packages to enhance functionality and design:

- `flutter_bloc`: For state management and business logic.
- `go_router`: For routing and navigation within the app.
- `top_snackbar_flutter`: For displaying custom snack bars and notifications.
- `carousel_slider`: For creating image carousels in the app.
- `http`: For making HTTP requests to the movie database API.
- `another_carousel_pro`: For implementing image carousels with advanced customization options.
