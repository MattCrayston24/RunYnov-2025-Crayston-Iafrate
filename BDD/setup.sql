-- Crée la base de données
CREATE DATABASE IF NOT EXISTS running_app CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE running_app;

-- Table users
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    username VARCHAR(100),
    profile_picture TEXT,
    role VARCHAR(20) DEFAULT 'user',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    verified BOOLEAN DEFAULT FALSE,
    email_verification_token TEXT,
    temp_email VARCHAR(255)
);

-- Table courses
CREATE TABLE courses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    distance FLOAT,
    duration INT,
    start_time DATETIME,
    path JSON,
    avg_speed FLOAT,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Table daily_goals
CREATE TABLE daily_goals (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    date DATE,
    label VARCHAR(255),
    completed BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Table goal_templates
CREATE TABLE goal_templates (
    id INT AUTO_INCREMENT PRIMARY KEY,
    type VARCHAR(50),
    value FLOAT,
    unit VARCHAR(10),
    active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table likes
CREATE TABLE likes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    course_id INT,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE
);

-- Table comments
CREATE TABLE comments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    course_id INT,
    content TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE
);

-- Table logins
CREATE TABLE logins (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    ip_address VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Table notifications
CREATE TABLE notifications (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255),
    message TEXT,
    date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ✅ Table feedbacks (à ajouter)
CREATE TABLE feedbacks (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    content TEXT NOT NULL,
    rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);
