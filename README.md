# flutter_canpass_login

A Flutter package that enhance CANPass login sdk https://docs.google.com/document/d/1beMpcbu8ebyY1xHR6BF-gXq2lkeWvZujOgyKeKqfmqA/edit

**environment:**
  - sdk: ">=2.7.0 <3.0.0"
  - flutter: ">=2.0.0"

**Features:** login with canpass account, get email from account

Supported `Android`, `Ios`

# Install:
```
  flutter_canpass_login:
    git: https://git.baikal.io/mobile/boilerplate/flutter_canpass_login
```

# Init:
```
await FlutterCanPassLogin.getInstance().init(
    secret: your_secret, 
    identifier: client_id);
```
# Functions:
##### login:
return the canpass account object
```
    final account = await FlutterCanPassLogin.getInstance().logIn(context);
```
##### logOut:
clear the accesstoken
```
    FlutterCanPassLogin.getInstance().logOut();
```
##### getCurrentToken:
return current accesstoken
```
    FlutterCanPassLogin.getInstance().getCurrentToken();
```

##### getCurrentAccount:
return current account from given token
```
    FlutterCanPassLogin.getInstance().getCurrentAccount(accesstoken);
```

##### to get secret key
go to https://developer.canpass.me/, create an app and then create OAuth2 clients 

##### demo
https://drive.google.com/file/d/1uNKeNt7GaD1lEt8NUxdwfjXqm716o1yF/view?usp=sharing
