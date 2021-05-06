# tenovatersenquiry

A Enquiry application for Tenovaters Groups which uses AWS as for authentican and storage using Amplify plugin

## Getting Started

Cautions: AWS Amplply plugin is in beta stage it is not advisable to use in Production Applications

1) Signup for an [AWS account](https://console.aws.amazon.com/console/home)

2)  [Install Amplify CLI](https://docs.amplify.aws/cli/start/install)

3) Once you have the correct version of amplify installed open your favorite Terminal/shell in the corresponding project directory path and type. Then configure the project using, check the [aws website](https://docs.amplify.aws/cli/start/install#option-2-follow-the-instructions) for more details. Keep a note once the configuration is set these can't be changed in the future.
   
   ```bash
   $ amplify configure
  ```
4) intitallize the project
   
   ```bash
   $ amplify init
   ```
   This should create a amplifyconfiguration.dart and amplify folder in the project directory.

5) Adding authentication plugin to the project
   ```bash
   $ amplify add auth
   ```
6) Push the local changes to the cloud using
   ```bash
   $ amplify push
   ```
 Now the project should work with amplify congnito plugin. To verify the status use
 ```bash
 $ amplify status
 ```
 Todo's
 - [ ] Forget Password
 - [ ] Resend OTP
 - [ ] Save User name while authentication
 
You should see the table in the terminal which shows the plugin is added in the project.
<p align="center">
<img src="https://github.com/msavanan/images_readme/blob/main/tenovatersenquiry/tenavators_gif.gif" width="300"/>
</p>
