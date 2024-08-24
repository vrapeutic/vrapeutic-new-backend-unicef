# Get all Centers
## steps:
* [get otp to use it in next request (if otp is not existed or expired)](https://documenter.getpostman.com/view/12318086/2sA3Bt3pg1#7efa3ce6-4e19-4748-ae9f-af03d4e78d74)
* otp will sent to admin email, and you should use it with the otp http header
* [get all centers](https://documenter.getpostman.com/view/12318086/2sA3Bt3pg1#08986376-322a-4ef8-9f4e-a76f77f41faa)
* also you can include related data for centers by using query params as `?include=children,doctors,sessions,software_modules,specialties,headsets,center_social_links`