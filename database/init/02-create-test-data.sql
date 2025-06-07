-- This script creates test data for development and testing environments
-- It will be skipped in production by checking the MYSQL_ENV variable in the entrypoint

-- Check if we're in development or test environment
SET @env = IFNULL(@env, 'unknown');
SELECT IFNULL(@@hostname, 'unknown') INTO @hostname;

-- Only run in development or test environments
DELIMITER //
BEGIN
    -- Create a sample table for testing
    CREATE TABLE IF NOT EXISTS `app_db`.`sample_data` (
        `id` INT AUTO_INCREMENT PRIMARY KEY,
        `name` VARCHAR(100) NOT NULL,
        `description` TEXT,
        `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );

    -- Insert some test data if the table is empty
    INSERT INTO `app_db`.`sample_data` (`name`, `description`)
    SELECT 'Test Item 1', 'This is a test item for development'
    WHERE NOT EXISTS (SELECT 1 FROM `app_db`.`sample_data` WHERE `name` = 'Test Item 1');

    INSERT INTO `app_db`.`sample_data` (`name`, `description`)
    SELECT 'Test Item 2', 'Another test item for development'
    WHERE NOT EXISTS (SELECT 1 FROM `app_db`.`sample_data` WHERE `name` = 'Test Item 2');

    INSERT INTO `app_db`.`sample_data` (`name`, `description`)
    SELECT 'Test Item 3', 'Yet another test item for development'
    WHERE NOT EXISTS (SELECT 1 FROM `app_db`.`sample_data` WHERE `name` = 'Test Item 3');

    -- Log the initialization
    SELECT CONCAT('Test data initialized in database app_db on host ', @hostname) AS message;
END //
DELIMITER ;
