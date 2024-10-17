| HTTP Verb  | Endpoint                                                     | Description                          |
| ---------- | ------------------------------------------------------------ | ------------------------------------ |
| **GET**    | /                                                            | Health check                         |
| **POST**   | /api/v1/sign_in                                              | Sign in                              |
| **GET**    | /api/v1/forget_password                                      | Forget password                      |
| **POST**   | /api/v1/reset_password                                       | Reset password                       |
| **POST**   | /api/v1/validate_otp                                         | Validate OTP                         |
| **GET**    | /api/v1/specialties                                          | List specialties                     |
| **GET**    | /api/v1/diagnoses                                            | List diagnoses                       |
| **GET**    | /api/v1/targeted_skills                                      | List targeted skills                 |
| **POST**   | /api/v1/sessions                                             | Create session                       |
| **PUT**    | /api/v1/sessions/:id/add_module                              | Add module to session                |
| **PUT**    | /api/v1/sessions/:id/add_doctor                              | Add doctor to session                |
| **PUT**    | /api/v1/sessions/:id/end_session                             | End session                          |
| **POST**   | /api/v1/sessions/:id/add_comment                             | Add comment to session               |
| **PUT**    | /api/v1/sessions/:id/add_evaluation                          | Add evaluation to session            |
| **PUT**    | /api/v1/sessions/:id/add_note_and_evaluation                 | Add note and evaluation to session   |
| **POST**   | /api/v1/sessions/:id/add_evaluation_file                     | Add evaluation file to session       |
| **POST**   | /api/v1/doctors                                              | Create doctor                        |
| **PUT**    | /api/v1/doctors/:id                                          | Update doctor                        |
| **POST**   | /api/v1/doctors/:id/validate_otp                             | Validate OTP for doctor              |
| **PUT**    | /api/v1/doctors/:id/resend_otp                               | Resend OTP for doctor                |
| **POST**   | /api/v1/doctors/complete_profile                             | Complete doctor profile              |
| **GET**    | /api/v1/doctors/centers                                      | List centers                         |
| **GET**    | /api/v1/doctors/center_assigned_children                     | List assigned children for center    |
| **GET**    | /api/v1/doctors/center_headsets                              | List headsets for center             |
| **GET**    | /api/v1/doctors/center_child_modules                         | List modules for center child        |
| **GET**    | /api/v1/doctors/center_child_doctors                         | List doctors for center child        |
| **GET**    | /api/v1/doctors/center_child_sessions                        | List sessions for center child       |
| **GET**    | /api/v1/doctors/home_centers                                 | List home centers                    |
| **GET**    | /api/v1/doctors/home_doctors                                 | List home doctors                    |
| **GET**    | /api/v1/doctors/home_kids                                    | List home kids                       |
| **GET**    | /api/v1/doctors/center_statistics                            | Get center statistics                |
| **GET**    | /api/v1/doctors/center_vr_minutes                            | Get center VR minutes                |
| **GET**    | /api/v1/doctors/sessions_percentage                          | Get sessions percentage              |
| **GET**    | /api/v1/doctors/kids_percentage                              | Get kids percentage                  |
| **POST**   | /api/v1/centers                                              | Create center                        |
| **PUT**    | /api/v1/centers/:id                                          | Update center                        |
| **POST**   | /api/v1/centers/:center_id/invite_doctor                     | Invite doctor to center              |
| **POST**   | /api/v1/centers/:center_id/assign_doctor                     | Assign doctor to center              |
| **PUT**    | /api/v1/centers/:center_id/make_doctor_admin                 | Make doctor admin of center          |
| **POST**   | /api/v1/centers/:center_id/add_child                         | Add child to center                  |
| **PUT**    | /api/v1/centers/:center_id/edit_child                        | Edit child in center                 |
| **POST**   | /api/v1/centers/:center_id/add_headset                       | Add headset to center                |
| **PUT**    | /api/v1/centers/:center_id/edit_headset                      | Edit headset in center               |
| **POST**   | /api/v1/centers/:center_id/add_modules                       | Add modules to center                |
| **PUT**    | /api/v1/centers/:center_id/assign_module_child               | Assign module to child               |
| **PUT**    | /api/v1/centers/:center_id/unassign_module_child             | Unassign module from child           |
| **PUT**    | /api/v1/centers/:center_id/assign_doctor_child               | Assign doctor to child               |
| **PUT**    | /api/v1/centers/:center_id/unassign_doctor_child             | Unassign doctor from child           |
| **GET**    | /api/v1/centers/:center_id/all_doctors                       | List all doctors in center           |
| **GET**    | /api/v1/centers/:center_id/doctors                           | List doctors in center               |
| **GET**    | /api/v1/centers/:center_id/doctors/:id                       | Get doctor in center                 |
| **PUT**    | /api/v1/centers/:center_id/doctors/:id/assign_doctor_child   | Assign doctor to child               |
| **PUT**    | /api/v1/centers/:center_id/doctors/:id/unassign_doctor_child | Unassign doctor from child           |
| **GET**    | /api/v1/centers/:center_id/sessions                          | List sessions in center              |
| **GET**    | /api/v1/centers/:center_id/sessions/:id                      | Get session in center                |
| **GET**    | /api/v1/centers/:center_id/sessions/evaluations              | List session evaluations in center   |
| **GET**    | /api/v1/centers/:center_id/kids                              | List children in center              |
| **GET**    | /api/v1/centers/:center_id/kids/:id                          | Get child in center                  |
| **GET**    | /api/v1/centers/:center_id/modules                           | List modules in center               |
| **GET**    | /api/v1/centers/:center_id/modules/:id                       | Get module in center                 |
| **POST**   | /api/v1/centers/:center_id/modules/add_modules               | Add modules to center                |
| **PUT**    | /api/v1/centers/:center_id/modules/:id/assign_module_child   | Assign module to child               |
| **PUT**    | /api/v1/centers/:center_id/modules/:id/unassign_module_child | Unassign module from child           |
| **GET**    | /api/v1/centers/:center_id/assigned_modules                  | Get assigned modules in center       |
| **GET**    | /api/v1/admins/kids                                          | List admin children                  |
| **PUT**    | /api/v1/admins/edit_child                                    | Edit child                           |
| **PUT**    | /api/v1/admins/edit_doctor                                   | Edit doctor                          |
| **PUT**    | /api/v1/admins/edit_headset                                  | Edit headset                         |
| **DELETE** | /api/v1/admins/delete_headset/:headset_id                    | Delete headset                       |
| **POST**   | /api/v1/software_modules                                     | Create software module               |
| **PUT**    | /api/v1/software_modules/:id                                 | Update software module               |
| **POST**   | /api/v1/admins/assign_center_headset/:center_id              | Assign headset to center             |
| **POST**   | /api/v1/admins/assign_center_module                          | Assign module to center              |
| **POST**   | /api/v1/admins/send_otp                                      | Send OTP                             |
| **GET**    | /api/v1/admins/doctors                                       | List admin doctors                   |
| **GET**    | /api/v1/admins/doctors/:id                                   | Get admin doctor                     |
| **PUT**    | /api/v1/admins/doctors/:id                                   | Update admin doctor                  |
| **GET**    | /api/v1/admins/children                                      | List admin children                  |
| **GET**    | /api/v1/admins/children/:id                                  | Get admin child                      |
| **PUT**    | /api/v1/admins/children/:id                                  | Update admin child                   |
| **GET**    | /api/v1/admins/software_modules                              | List admin software modules          |
| **GET**    | /api/v1/admins/software_modules/:id                          | Get admin software module            |
| **POST**   | /api/v1/admins/software_modules                              | Create admin software module         |
| **PUT**    | /api/v1/admins/software_modules/:id                          | Update admin software module         |
| **GET**    | /api/v1/admins/centers                                       | List admin centers                   |
| **GET**    | /api/v1/admins/centers/:id                                   | Get admin center                     |
| **GET**    | /api/v1/admins/centers/:id/session_evaluations               | Get session evaluations for center   |
| **POST**   | /api/v1/admins/centers/assign_center_module                  | Assign module to center              |
| **POST**   | /api/v1/admins/centers/:center_id/assign_center_headset      | Assign headset to center             |
| **GET**    | /api/v1/admins/specialties                                   | List admin specialties               |
| **GET**    | /api/v1/admins/specialties/:id                               | Get admin specialty                  |
| **GET**    | /api/v1/admins/headsets                                      | List admin headsets                  |
| **GET**    | /api/v1/admins/headsets/:id                                  | Get admin headset                    |
| **PUT**    | /api/v1/admins/headsets/:id                                  | Update admin headset                 |
| **DELETE** | /api/v1/admins/headsets/:headset_id                          | Delete admin headset                 |
| **POST**   | /api/v1/admins/otps/send_otp                                 | Send OTP                             |
| **GET**    | /api/v1/headsets/:id/free_headset                            | Free Headset                         |
