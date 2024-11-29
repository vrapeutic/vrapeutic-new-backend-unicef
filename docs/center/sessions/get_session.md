# Get Sesssion

## steps:

- [get otp to use it in next request (if otp is not existed or expired)](https://documenter.getpostman.com/view/12318086/2sA3Bt3pg1#7efa3ce6-4e19-4748-ae9f-af03d4e78d74)
- otp will sent to admin email, and you should use it with the otp http header
- [get session](https://documenter.getpostman.com/view/12318086/2sA3Bt3pg1#2f287d3c-8fc2-47e6-884c-1c0e981203b5)
- also you can include related data for session by using query params as `?include=software_modules,center,child,headset,doctors`
