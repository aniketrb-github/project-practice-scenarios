-- DROP DATABASE `project_portal_mgt_db` ;
-- CREATE SCHEMA `project_portal_mgt_db` ;

-- TABLE: PROJECTS
CREATE TABLE tbl_projects (
`id` INT(8) NOT NULL AUTO_INCREMENT,
`name` VARCHAR(128) NOT NULL,
`deleted` TINYINT(1) NOT NULL DEFAULT 0,
`resource_strength` INT(3) NOT NULL DEFAULT 1,
`start_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
`end_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
`code` VARCHAR(10) NOT NULL UNIQUE,
PRIMARY KEY(`id`)
);

-- TABLE: EMPLOYEES 
CREATE TABLE tbl_employees (
`id` INT(8) NOT NULL AUTO_INCREMENT,
`name` VARCHAR(128) NOT NULL,
`email` VARCHAR(128) UNIQUE NOT NULL,
`designation` VARCHAR(128) NOT NULL,
`platform` VARCHAR(64) NULL,
`project_id` INT(8) NOT NULL,	-- foreignKey1
`deleted` TINYINT(1) NOT NULL DEFAULT 0,
`joining_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY(`id`),
KEY `tbl_projects_fk1` (`project_id`),
CONSTRAINT `tbl_projects_fk1` FOREIGN KEY (`project_id`) REFERENCES `tbl_projects` (`id`)
);	

-- TABLE: TASKS
CREATE TABLE tbl_tasks (
`id` INT(8) NOT NULL AUTO_INCREMENT,
`name` VARCHAR(128) NOT NULL,
`description` VARCHAR(128) NOT NULL,
`start_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
`end_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
`project_id` INT(8) NOT NULL,	-- foreignKey1
`assigned_to` INT(8) NOT NULL,  -- foreignKey2
`reported_by` INT(8) NOT NULL,  -- foreignKey3
`status_id` INT(2) NOT NULL,	-- foreignKey4
`deleted` TINYINT(1) NOT NULL DEFAULT 0,
PRIMARY KEY(`id`),
KEY `tbl_projects_fk1` (`project_id`),
CONSTRAINT `tbl_projects_fk1` FOREIGN KEY (`project_id`) REFERENCES `tbl_projects` (`id`),
KEY `tbl_employees_fk1` (`assigned_to`),
CONSTRAINT `tbl_employees_fk1` FOREIGN KEY (`assigned_to`) REFERENCES `tbl_employees` (`id`),
KEY `tbl_employees_fk2` (reported_by),
CONSTRAINT `tbl_employees_fk2` FOREIGN KEY (`reported_by`) REFERENCES `tbl_employees` (`id`),
KEY `tbl_status_fk1` (`status_id`),
CONSTRAINT `tbl_status_fk1` FOREIGN KEY (`status_id`) REFERENCES `tbl_status` (`id`)
);

-- TABLE: BUG STATUSES
CREATE TABLE tbl_status (
`id` INT(8) NOT NULL,
`name` VARCHAR(32) NOT NULL,
`deleted` TINYINT(1) NOT NULL DEFAULT 0,
PRIMARY KEY(`id`)
);

-- TABLE: BUG
CREATE TABLE tbl_bugs (
`id` INT(8) NOT NULL,
`name` VARCHAR(32) NOT NULL,
`description` VARCHAR(128) NOT NULL,
`task_id` INT(8) NOT NULL,		-- foreignKey1
`status_id` INT(2) NOT NULL,	-- foreignKey2
`employee_id` INT(8) NOT NULL,  -- foreignKey3
`deleted` TINYINT(1) NOT NULL DEFAULT 0,
PRIMARY KEY(`id`),
KEY `tbl_tasks_fk1` (`task_id`),
CONSTRAINT `tbl_tasks_fk1` FOREIGN KEY (`task_id`) REFERENCES `tbl_tasks` (`id`),
KEY `tbl_status_fk1` (`status_id`),
CONSTRAINT `tbl_status_fk1` FOREIGN KEY (`status_id`) REFERENCES `tbl_status` (`id`),
KEY `tbl_employees_fk2` (`employee_id`),
CONSTRAINT `tbl_employees_fk2` FOREIGN KEY (`employee_id`) REFERENCES `tbl_employees` (`id`)
);

-- TABLE: EMPLOYEE_METADATA
CREATE TABLE tbl_employee_metadata (
`employee_id` INT(8) NOT NULL,  	-- foreignKey1
`username` VARCHAR(128) NOT NULL,
`password`VARCHAR(128) NOT NULL,
KEY `tbl_employees_fk3` (`employee_id`),
CONSTRAINT `tbl_employees_fk3` FOREIGN KEY (`employee_id`) REFERENCES `tbl_employees` (`id`)
);
/*
ALTER TABLE tbl_bugs 
DROP FOREIGN KEY tbl_employees_fk1;

ALTER TABLE tbl_tasks
ADD COLUMN `employee_id` INT(8) NOT NULL,
ADD FOREIGN KEY `tbl_employees_fk1`(`employee_id`)
REFERENCES `tbl_employees`(`id`);
*/

ALTER TABLE tbl_projects
ADD CONSTRAINT unique_project_code UNIQUE (project_code);