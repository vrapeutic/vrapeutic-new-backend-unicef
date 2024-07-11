# API 
## route 
* existing in routes file 
## controller 
* if the request requires authentication --> we will do `authorize` method in `base_api.rb` before action
* if request requires authorization ---> we will use `authorize_resource` and you should look for this action in the asssociated ability file 
## authorization
* for each controller we made ability file
* for each ability file we define actions 
* for each action we can apply service object to return true or false based on the current user and params
### example : update_center request 
* ability file : `center_ability.rb`
* action : `update`
* service object : in `services/authorization/center/can_update_service.rb`
## controller services
### most of contrllers have service object to handle it and avoid writing code in controller file like update center request : 
* controller : `centers_controller.rb`
* service object : `services/center/edit_service.rb`

## serializer
### most of get requests use serializer to define one shape of data to use it later
### we have 3 types of serializer : 
* normal serializer like : `center_serializer` --> used in center controller
* mini serializer like : `mini_center_serializer` ---> used in other controllers that we want to return center data 
* home serializer like : `home_center_serializer` ----> used in home requests that we retuen statistics about center and make heavy queries for it