# Movie App Engineering ReadMe

## Overview

Welcome to the Movie App project! This document provides essential information for engineers to quickly get started with the codebase. The Movie App is a SwiftUI-based iOS application that allows users to explore trending and top-rated movies, view favorites, and access additional features.

## User Interface

Check out the UI design on Dribbble: [Movie App UI](https://dribbble.com/shots/6389426-Movie-App)

The application is built using SwiftUI, ensuring a modern and intuitive user interface.

## Components

Custom UI components and modifiers can be found in the `UI/Components` folder. Feel free to explore and reuse these components in different parts of the application.

## Accessibility/Localization

- Colors are currently accessible.
- Text is localized to support a global audience.

## Tokens

The application leverages Color, text, and font tokens for consistent styling throughout the app.

## Features

Explore the following key features:

- **Trending Feature:** Discover trending movies.
- **Top Rated Feature:** Explore top-rated movies.
- **View All Feature:** View all available movies.
- **Favorites Feature:** Mark and manage favorite movies.

## Architecture (MVVM-C)

The Movie App follows the MVVM-C (Model-View-ViewModel-Coordinator) architecture:

- **Router:** Utilizes a custom router object named `Router` for easy navigation with a navigation stack.
- **Coordinator:** The app coordinator is the base and entry point where all feature routes/views are registered.
- **ViewModels:** Business logic resides in observable view models.
- **UI Layer:** Implemented in SwiftUI.
- **Dependency Injection:** The router is injected via the environment.

## Networking

The networking layer utilizes async/await APIs and is structured into requests, responses, and a client.

## Persistence

SwiftData is employed for persistence, ensuring efficient and reliable data storage.

## Testing

Unit tests are available for the view models, promoting code reliability and maintainability.

## Getting Started

1. Clone the repository.
2. Add your API key to the `AppConfig.xconfig` file.
3. Explore and contribute to the project!

Feel free to reach out if you have any questions or need further assistance. Happy coding!
