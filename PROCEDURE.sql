create database store_procedure;

create table irctc_users(
	user_id int auto_increment primary key,
    username varchar(35) not null unique,
    password varchar(255) not null,
    gender enum('male','female','others') not null,
    date_of_birth date not null,	
    occupation varchar(100) not null,
    country varchar(50) not null,
	mobile_number varchar(15) not null,
    email_id varchar(100) not null unique,
    created_at timestamp default current_timestamp);
    
    
create table user_security(
	sec_id int auto_increment primary key,
    user_id int not null,
    security_question text not null,
    answer varchar(100) not null,
    foreign key (user_id) references irctc_users(user_id) on delete cascade);
    
INSERT INTO irctc_users (
    username, password, gender, date_of_birth, occupation, country, mobile_number, email_id
) VALUES
('rahul_verma2', '$2y$10$examplehashedpwd1', 'Male', '1990-08-15', 'Engineer', 'India', '9876543211', 'rahul.verma21@example.com'),
('anjali_sharma', '$2y$10$examplehashedpwd2', 'Female', '1995-02-10', 'Teacher', 'India', '9123456789', 'anjali.sharma@example.com'),
('arjun_patil', '$2y$10$examplehashedpwd3', 'Male', '1988-11-05', 'Doctor', 'India', '9012345678', 'arjun.patil@example.com'),
('kavita_rani', '$2y$10$examplehashedpwd4', 'Female', '1992-06-25', 'Designer', 'India', '9345678901', 'kavita.rani@example.com'),
('manoj_nair', '$2y$10$examplehashedpwd5', 'Male', '1985-03-30', 'Banker', 'India', '9988776655', 'manoj.nair@example.com');

select * from irctc_users;

INSERT INTO user_security (user_id, security_question, answer) VALUES
-- For user_id = 1 (Rahul Verma)
(1, 'What was your childhood nickname?', 'Rahu'),
(1, 'What is the name of your first school?', 'St. Xavier'),

-- For user_id = 2 (Anjali Sharma)
(2, 'What is your mother’s maiden name?', 'Kapoor'),
(2, 'What is your favorite food?', 'Pani Puri'),

-- For user_id = 3 (Arjun Patil)
(3, 'What was the name of your first pet?', 'Tiger'),
(3, 'Which city were you born in?', 'Nagpur'),

-- For user_id = 4 (Kavita Rani)
(4, 'What is your favorite movie?', 'Dilwale Dulhania Le Jayenge'),
(4, 'What was the name of your childhood best friend?', 'Neha'),

-- For user_id = 5 (Manoj Nair)
(5, 'What is your dream job?', 'Pilot'),
(5, 'What is the name of your favorite teacher?', 'Mr. Iyer');

select * from user_security;


select * from irctc_users u, user_security us where u.user_id = us.user_id;

DELIMITER &&

create procedure register_user_with_security1 (
	in p_username varchar(35),
    in p_password varchar(255),
    in p_gender enum('male','female','others'),
    in p_date_of_birth date,
    in p_occupation varchar(100),
    in p_country varchar(50),
    in p_mobile_number varchar(15),
    in p_email_id varchar(100),
    in p_sec_question1 text,
    in p_answer1 varchar(100),
    in p_sec_question2 text,
    in p_answer2 varchar(100)
    )
begin
		declare new_user_id int;
        
        insert into	 irctc_users (
			 username, password, gender, date_of_birth, occupation, country, mobile_number, email_id
		) values ( p_username, p_password, p_gender, p_date_of_birth, p_occupation, p_country, p_mobile_number, p_email_id
		);
        
        
         SET new_user_id = LAST_INSERT_ID();

    -- Step 3: Insert two security questions
		INSERT INTO user_security (user_id, security_question, answer)
		VALUES 
        (new_user_id, p_sec_question1, p_answer1),
        (new_user_id, p_sec_question2, p_answer2);
END$$

DELIMITER &&
