# Get Sessions

## steps:

- [get otp to use it in next request (if otp is not existed or expired)](https://documenter.getpostman.com/view/12318086/2sA3Bt3pg1#7efa3ce6-4e19-4748-ae9f-af03d4e78d74)
- otp will sent to admin email, and you should use it with the otp http header
- [get sessions](https://documenter.getpostman.com/view/12318086/2sA3Bt3pg1#07ef2190-6e71-44a5-895a-472bd3d64708)
- also you can include related data for sessions by using query params as `?include=software_modules,center,child,headset,doctors`
