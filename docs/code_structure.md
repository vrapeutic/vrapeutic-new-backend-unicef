# API

## Routes

- (Routes)[https://github.com/vrapeutic/vrapeutic-new-backend-unicef/blob/main/docs/routes.md]

## Controller

- if the request requires authentication --> we will do `authorize` method in `base_api.rb` before action
- if request requires authorization ---> we will use `authorize_resource` and you should look for this action in the asssociated ability file

## Authorization

- for each controller we made ability file
- for each ability file we define actions
- for each action we can apply service object to return true or false based on the current user and params

### example : update_center request

- ability file : `center_ability.rb`
- action : `update`
- service object : in `services/authorization/center/can_update_service.rb`

## controller services

### most of contrllers have service object to handle it and avoid writing code in controller file like update center request :

- controller : `centers_controller.rb`
- service object : `services/center/edit_service.rb`

## serializer

### most of get requests use serializer to define one shape of data to use it later, and allow include related data for each type

### Existed Serializers:

| Serializer Name                | Attributes                                                                                                                                                                                                      | Included                                                          |
| ------------------------------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------- |
| **CenterSerializer**           | name, longitude, latitude, logo, website, email, phone_number, tax_id, certificate, registration_number, created_at, updated_at, logo_url, certificate_url, specialties_number, doctors_number, children_number | `children,doctors,sessions,software_modules,specialties,headsets` |
| **CenterSocialLinkSerializer** | link, link_type, center_id, created_at, updated_at                                                                                                                                                              | `center`                                                          |
| **HeadsetSerializer**          | model, key, center, center_id, created_at, updated_at                                                                                                                                                           | `center,sessions`                                                 |
| **SpecialtySerializer**        | name, created_at, updated_at                                                                                                                                                                                    | `centers,doctors`                                                 |
| **DiagnosisSerializer**        | name, created_at, updated_at                                                                                                                                                                                    | `children`                                                        |
