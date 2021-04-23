# tenovatersenquiry

A Enquiry application for Tenovaters Groups which uses AWS as for authentican and storage using Amplify plugin

## Getting Started

1) Signup for an [AWS account](https://console.aws.amazon.com/console/home)
2) [Install Amplify CLI](https://docs.amplify.aws/cli/start/install)
3) Once you have the correct version of amplify installed open your favorite Terminal/shell in the corresponding project directory path and type:
   
   ```bash
   $ amplify init
   ```
   This should create a amplifyconfiguration.dart and amplify folder in the project directory.
4) Next configure the project using, check the [aws website](https://docs.amplify.aws/cli/start/install#option-2-follow-the-instructions) for more details. Keep a note once the configuration is set these can't be changed in the future.
   ```bash
   $ amplify comfigure
   ```
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
You should see the table in the terminal which shows the plugin is added in the project.
