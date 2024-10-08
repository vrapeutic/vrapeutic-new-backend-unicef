# Core Tables

![ERD](/docs/vrapeutic_api_erd.png)

## Tables

### User Tables

- **doctors** : Doctor users [ email, password ]
  > name, email, password, degree, university, photo, certificate, is_email_verified
- **otps** : Doctors' Otps for [ email_verification , password_reset ]
  > doctor_id, code, expires_at, code_type
- **admins** : Super Admins [ emaill ]
  > otp, expires_at, email
- **children** : System Kids
  > name, email, age, photo

### System Tables

- **centers** : System's Centers
  > name, website, logo, certificate, registration_number, tax_id, email, phone_number
- **sessions** : Center's Sessions
  > center_id, headset_id, child_id, evaluation, duration, is_verified, ended_at, vr_duration, session_id, note, evaluation_file

### System's support Tables

- **headsets** : headsets
  > name, brand, model, version, key, center_id, discarded_at
- **software_modules** : software modules
  > name, version, technology, min_age, max_age, image, package_name
- **target_skills** : children's skills
  > name
- **specialties** : doctor's specialties
  > name
- **diagnoses** : diagnoses
  > name

## Table Relations

### Many-To-Many

---

#### Doctor

- Doctor has many centers, and center has many doctors through **doctor_centers**
  -- Doctor is **admin (manager)** or **worker (specialist)** for many centers
- Doctor has many specialties, and specialty has many doctors through **doctor_specialties**
- Doctor has many children, and child has many doctors through **child_doctors**, and for many centers
  -- Doctor is assigned to manage many children under many centers
- Doctor has many sessions, and session has many doctors through **session_doctors**
  -- Doctor can open manage many sessions

---

#### Child

- Child has many centers, and center has many children through **child_centers**
  -- Child is allocated in many centers
- Child has many doctors, and doctor has many children through **child_doctors**, and for many centers
  -- Child is assigned to manage many doctors under many centers
- Child has many diagnoses, and diagnosis has many children through **child_diagnoses**, and for many centers
  -- Child has many diagnoses under many centers
- Child has many software_modules, and software_module has many children through **child_software_modules**, and for many centers
  -- Child has many software_modules under many centers

---

#### Center

- Center has many children, and child has many children through **child_centers**
- Center has many specialties, and specialty has many doctors through **center_specialties**
- Center has many software_modules, and software_module has many centers through **assigned_center_modules**
- Center has many doctors, and center has many doctors through **doctor_centers**
  -- Center has **admin (manager)** or **worker (specialist)** role with each doctor

---

#### Session

- Session has many doctors, and doctor has many sessions through **session_doctors**
  -- Session managed by many doctors
- Session has many software_modules, and software_module has many sessions through **session_modules**

---

#### Software Module

- Software Module has many children, and child has many software_modules through **child_software_modules**, and for many centers
- Software Module has many centers, and center has many software_modules through **assigned_center_modules**
- Software Module has many sessions, and session has many software_modules through **session_modules**
- Software Module has many target_skills, and target_skill has many software_modules through **software_module_skills**

---

#### Targeted Skill

- Targeted Skill has many software_modules, and software_module has many target_skills through **software_module_skills**

---

#### Specialty

- Specialty has many doctors, and doctor has many specialties through **doctor_specialties**
- Specialty has many centers, and center has many specialties through **center_specialties**

---

#### Diagnosis

- Diagnosis has many children, and child has many diagnoses through **child_diagnoses**

---

### One-To-Many

---

#### Doctor

- Doctor has many **otps**, and otp has only one doctor
  -- doctor has many otps' types ( email_verification, reset_password)

---

#### Child

- Child has many **sessions**, and session has only one child

---

#### Center

- Center has many **center_social_links**, and center_social_link has only one center
- Center has many **sessions**, and session has only one center
- Center has many **headsets**, and headset has only one center

---

#### Session

- Session has many **session_comments**, and session_comment has only one session
