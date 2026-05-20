# 🏋️ Gym Management & Database Administration System

Welcome to the Gym Management System repository. This project delivers a scalable, structured, and consistent relational database backend engineered using MySQL to automate fitness facility workflows, protect historical data transactions, and optimize administration reporting.

---

## 🏛️ University & Course Context
* Institution: Innovation University (IU) - Faculty of Computer and Information Technology
* Course: Database Systems
* Instructor: Dr. Marwa
* Project Team:
  - Dalia Mohamed Zaki
  - Sama Mohsen Hussien
  - Hana Hani Mostafa
  - Malak Mohamed Said
  - Mennatallah Mohamed El Sayed

---

## 🎯 Core Objectives & Features
* Automate Operations: Structures data workflows linking members, trainers, plans, financial transactions, and class check-ins.
* Relational Consistency: Implements strict foreign key constraints, explicit unique filters, and standard validation rules (e.g., handling minimum age and absolute prices).
* Advanced Database Architecture: Enforces automated deletion blocks using custom Triggers, isolates administrative adjustments via Stored Procedures, and computes granular statistics via user-defined Scalar Functions.

---

## 📊 Database Architecture & Entity Descriptions
The backend architecture is modeled around 8 interconnected tables designed to streamline gym operations:

1. Members: Holds client profiles, enforcing unique contact parameters (Phone/Email) and age boundaries.
2. Trainers: Contains coach credentials, assigned specialties, and operational overhead configurations.
3. MembershipPlans: Defines custom subscriptions, duration metrics, and specific plan valuations.
4. MemberMemberships: An associative bridge entity mapping the many-to-many subscription historical ledger between members and plans.
5. Payments: Documents monetary transactions tied back to explicit member profiles and activated plan models.
6. Attendance: Monitors chronological daily gym check-ins utilizing automated structural timestamps.
7. Classes: Manages organized physical training sessions mapped out by time blocks and assigned trainers.
8. ClassesRegistrations: Records member sign-ups across ongoing athletic group training classes.

---

## 🗂️ Project Repository Structure
Your repository contains the following required operational modules:
* 📄 GYM MANAGMENT SYSTEM.pdf: The master technical report and proposal detailing design theory and system specs.
* 💻 GYM_MANAGMENT_SYSTEM.sql: The production-ready database execution script hosting full DDL setups and DML query workflows.
* 🖼️ ERD.jpeg: The interactive visual diagram outlining primary components, entity parameters, and data links.
* 🗺️ SCHEMA.jpeg: High-resolution visualization mapped directly inside MySQL Workbench illustrating structural table connections.
* 📜 Acknowledgement.md: Expressing appreciation to course instructors and outlining team roles.

---

## 🛠️ Technology Stack
* Database Management System: MySQL
* Integrated Development Interface (IDE): MySQL Workbench
* Design & Modeling Tools: Workbench EER Diagram Engine
