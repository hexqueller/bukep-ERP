-- Таблица пользователей (Users)
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    email VARCHAR(100) UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Тестовые данные для таблицы пользователей
INSERT INTO users (username, password_hash, email) VALUES
('admin', 'hashed_password_1', 'admin@example.com'),
('user1', 'hashed_password_2', 'user1@example.com'),
('user2', 'hashed_password_3', 'user2@example.com');

-- Таблица счетов (Accounts)
CREATE TABLE accounts (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id) ON DELETE CASCADE,
    name VARCHAR(100) NOT NULL,
    balance DECIMAL(15, 2) DEFAULT 0.00,
    currency VARCHAR(10) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Тестовые данные для таблицы счетов
INSERT INTO accounts (user_id, name, balance, currency) VALUES
(1, 'Основной счет', 10000.00, 'RUB'),
(2, 'Сберегательный счет', 5000.00, 'USD'),
(3, 'Инвестиционный счет', 15000.00, 'EUR');

-- Таблица категорий (Categories)
CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
);

-- Тестовые данные для таблицы категорий
INSERT INTO categories (name, description) VALUES
('Зарплата', 'Поступления от работы'),
('Продукты', 'Расходы на продукты питания'),
('Транспорт', 'Расходы на транспорт'),
('Развлечения', 'Расходы на развлечения');

-- Таблица транзакций (Transactions)
CREATE TABLE transactions (
    id SERIAL PRIMARY KEY,
    account_id INT REFERENCES accounts(id) ON DELETE CASCADE,
    category_id INT REFERENCES categories(id) ON DELETE SET NULL,
    amount DECIMAL(15, 2) NOT NULL,
    type VARCHAR(10) CHECK (type IN ('income', 'expense')),
    description TEXT,
    transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Тестовые данные для таблицы транзакций
INSERT INTO transactions (account_id, category_id, amount, type, description) VALUES
(1, 1, 50000.00, 'income', 'Зарплата за январь'),
(1, 2, -2000.00, 'expense', 'Покупка продуктов в магазине'),
(2, 3, -500.00, 'expense', 'Заправка автомобиля'),
(3, 4, -1000.00, 'expense', 'Поход в кино');

-- Таблица бюджетов (Budgets)
CREATE TABLE budgets (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id) ON DELETE CASCADE,
    category_id INT REFERENCES categories(id) ON DELETE CASCADE,
    amount DECIMAL(15, 2) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL
);

-- Тестовые данные для таблицы бюджетов
INSERT INTO budgets (user_id, category_id, amount, start_date, end_date) VALUES
(1, 2, 5000.00, '2023-10-01', '2023-10-31'),
(2, 3, 1000.00, '2023-10-01', '2023-10-31'),
(3, 4, 2000.00, '2023-10-01', '2023-10-31');

-- Таблица целей (Goals)
CREATE TABLE goals (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id) ON DELETE CASCADE,
    name VARCHAR(100) NOT NULL,
    target_amount DECIMAL(15, 2) NOT NULL,
    current_amount DECIMAL(15, 2) DEFAULT 0.00,
    target_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Тестовые данные для таблицы целей
INSERT INTO goals (user_id, name, target_amount, current_amount, target_date) VALUES
(1, 'Новый автомобиль', 1000000.00, 200000.00, '2024-12-31'),
(2, 'Путешествие в Европу', 300000.00, 50000.00, '2024-06-30'),
(3, 'Ремонт квартиры', 500000.00, 100000.00, '2024-03-31');