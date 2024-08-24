# Get Doctor

## steps:

- [get otp to use it in next request (if otp is not existed or expired)](https://documenter.getpostman.com/view/12318086/2sA3Bt3pg1#7efa3ce6-4e19-4748-ae9f-af03d4e78d74)
- otp will sent to admin email, and you should use it with the otp http header
- [get doctor](https://documenter.getpostman.com/view/12318086/2sA3Bt3pg1#647f23bf-7b7c-40f0-a0df-4262092d441d)
- also you can include related data for doctors by using query params as `?include=specialties,children,centers,sessions`
