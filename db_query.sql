CREATE DATABASE gym_system;
USE gym_system;

-- 1. Users (accounts)
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Gyms
CREATE TABLE gyms (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    location VARCHAR(255)
);

-- 3. Membership plans
CREATE TABLE membership_plans (
    id INT AUTO_INCREMENT PRIMARY KEY,
    gym_id INT NOT NULL,
    name VARCHAR(100),
    monthly_price DECIMAL(6,2),
    FOREIGN KEY (gym_id) REFERENCES gyms(id)
);

-- 4. M:N Join table (users <-> memberships)
CREATE TABLE user_memberships (
    user_id INT,
    membership_id INT,
    start_date DATE,
    PRIMARY KEY (user_id, membership_id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (membership_id) REFERENCES membership_plans(id)
);

-- 5. Check-ins
CREATE TABLE checkins (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    gym_id INT,
    checkin_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (gym_id) REFERENCES gyms(id)
);

