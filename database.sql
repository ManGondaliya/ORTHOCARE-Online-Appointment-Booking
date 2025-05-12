create database orthocare;

use orthocare;

CREATE TABLE user (
    user_id INT AUTO_INCREMENT PRIMARY KEY,         
    full_name VARCHAR(100) NOT NULL,                
    email VARCHAR(100) NOT NULL UNIQUE,              
    password VARCHAR(255) NOT NULL,                  
    phone_number VARCHAR(15) NOT NULL,               
    address TEXT,                                    
    gender VARCHAR(10),                               
    date_of_birth DATE,                              
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP  
);

CREATE TABLE Appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id VARCHAR(20) NOT NULL,
    patient_name VARCHAR(20) NOT NULL,
    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL,
    doctor_name VARCHAR(20) NOT NULL,
    status VARCHAR(20) DEFAULT 'Scheduled',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE Doctor (
    DoctorID INT AUTO_INCREMENT PRIMARY KEY, 
    DoctorName VARCHAR(100) NOT NULL,        
    Mobile VARCHAR(15) NOT NULL,             
    Email VARCHAR(100) UNIQUE NOT NULL,      
    Specialization VARCHAR(100) NOT NULL,    
    Qualification VARCHAR(100) NOT NULL,     
    Password VARCHAR(255) NOT NULL,          
    ConsultationFee VARCHAR(255) NOT NULL, 
    Availability VARCHAR(100) NOT NULL,      
    Status VARCHAR(50) DEFAULT 'Active'    
);

INSERT INTO Doctor (DoctorName, Mobile, Email, Specialization, Qualification, Password, ConsultationFee, Availability, Status)
VALUES 
('Dr. Nirav Shah', '9876543210', 'nirav.shah@gmail.com', 'Joint Replacement', 'MBBS, MS', 'nirav123', '1500.00', 'Tue-Fri, 9 AM - 3 PM', 'Active'),
('Dr. Nisha Bhatt', '9958875813', 'nisha.bhatt@yahoo.com', 'Consultant Orthopedic', 'MBBS, MD', 'nisha123', '1000.00', 'Mon-Sat, 10 AM - 4 PM', 'Active'),
('Dr. Tarun Goyal', '7895421317', 'tarun.goyal@yahoo.com', 'Orthopedic Surgeon', 'MBBS, MS (Orthopedics)', 'tarun123', '1000.00', 'Mon-Thu, 10 AM - 4 PM', 'Active'),
('Dr. Aarti Rai ', '9978585474', 'Aarti.rai@gamil.com', 'Physiotherapist', 'BPT, MPT (Orthopedic Physiotherapy)', 'aarti123', '1000.00', 'Mon-Sat, 10 AM - 5 PM', 'Active');
	

CREATE TABLE admin (
    AdminID INT PRIMARY KEY AUTO_INCREMENT,
    Username VARCHAR(50) NOT NULL UNIQUE,
    Password VARCHAR(255) NOT NULL -- Store hashed passwords for better security
);

insert into admin (Username,Password) values('admin','admin1234');

select * from admin;



