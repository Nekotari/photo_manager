# Photo Manager

A simple photo sharing application built with Ruby on Rails.

## Features

- **User Authentication:** Users can sign up, log in, and log out.
- **Photo Uploads:** Users can upload photos with descriptions.
- **Image Storage:** Photos are stored using Active Storage.
- **Validations:** Photos must have an image attached and a description within 30 characters.

## Setup

### Requirements

- Ruby (version 3.3.1)
- Ruby on Rails (version 7.1.3)

### Installation

1. **Clone the repository:**

   ```bash
   git clone https://github.com/Nekotari/photo_manager.git
2. **Install dependencies:**
   ```bash
   cd photo_manager
   bundle install
3. **Set up the database:**
    ```bash
   rails db:create
   rails db:migrate
4. **Start the Rails server:**
    ```bash
   rails server
5. **Open your browser and visit http://localhost:3000 to view the application.**

### Testing

Not implemented without external dependencies
