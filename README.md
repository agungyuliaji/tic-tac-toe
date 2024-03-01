# README

This is a simple web-based Tic-Tac-Toe application built with Ruby on Rails. It allows two players to play Tic-Tac-Toe against each other in the same session of the webpage.

### Prerequisites

Before you begin, ensure you have Ruby and Rails installed on your system. This application requires:

- Ruby version: 3.3.0
- Rails version: 7.1.3

### Setup

To get the application running, follow these steps:

1. **Clone the repository**
2. **Install dependencies**

    Navigate to the project directory and execute `./bin/setup` in your terminal. This command installs all necessary dependencies for the application. Feel free to grab a cup of coffee in the meantime!

3. **Run Local Development Server**

    Once dependencies are installed, start the local development server with `./bin/dev`. This command boots up the application on your local server, making it accessible through your web browser via `http://localhost:3000`


### Application Structure

The application avoids using a database to keep the setup lightweight and straightforward. Instead, it utilizes session data to manage game states and player movements. While sessions can become challenging for more complex tasks, the support of a dedicated class (GameManager) simplifies maintenance and scalability. Core components game's logic primarily resides within two files:

- Service: `app/services/game_manager.rb`

  This service class manages game states, player turns, and win/draw conditions.

- Controller: `app/controllers/games_controller.rb`

  The controller handles HTTP requests, interacts with the GameManager, and updates the session data accordingly.

### 3rd Party dependencies

The application leverages several Rails 7 features and third-party libraries for an enhanced user experience:

- Styling: Bootstrap, alongside `dartsass-rails` and `cssbundling-rails` for Sass support.
- Testing: RSpec for comprehensive testing of application logic and behavior.