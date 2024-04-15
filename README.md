This project focuses on a critical aspect of the DevOps learning journey: implementing a CI/CD pipeline. As an aspiring engineer, I created a React application and recognized the value of establishing an automated deployment process through CI/CD.

In my role as both a developer and a DevOps engineer, I’m well aware of the challenges associated with manual deployments. The process can become chaotic and consume valuable time. However, the introduction of CI/CD pipelines has revolutionized this landscape by offering developers the ability to seamlessly deploy their code changes. This not only simplifies the deployment process but also enhances efficiency, enabling a smoother and more reliable workflow.

Introduction
CI/CD is a set of automated processes that facilitate the development, testing, and deployment of software applications. It is a crucial part of modern software development practices, enabling teams to deliver code changes more frequently, reliably, and with higher quality.

Steps to create a CI/CD pipeline
Choose a project to deploy on github
Create IAM roles for EC2 and CodeDeploy
Create an EC2 instance (attach IAM role, add user, install CodeDeploy Agent)
Create AWS CodePipeline
Create AWS CodeBuild
Create AWS CodeDeploy
Github Project

To effectively establish and validate a CI/CD pipeline, several essential steps must be taken. These steps include selecting an appropriate project for deployment, gaining a comprehensive understanding of the project’s particulars such as the programming language and framework employed. Notably, distinct frameworks are employed for various project components. Frontend projects, for instance, often utilize frameworks such as ReactJS, VueJS, or AngularJS. In contrast, backend projects commonly rely on frameworks like Django, Flask, or SpringBoot.

Due to the inherent differences among the various frameworks used in both frontend and backend development, deploying projects built with these frameworks indeed requires distinct approaches. These distinctions stem from the unique characteristics, architectures, and tooling associated with each framework. As a result, deploying projects using ReactJS, VueJS, AngularJS, Django, Flask, or SpringBoot involves tailored strategies to ensure optimal results.

For a DevOps engineer tasked with orchestrating CI/CD pipelines, an in-depth grasp of each framework’s prerequisites is crucial prior to pipeline creation. This comprehension enables the engineer to tailor the pipeline to the unique requirements of each framework. By harmonizing the pipeline with the framework’s specifications, seamless and efficient deployment becomes attainable. Consequently, the DevOps engineer plays a pivotal role in bridging the gap between development and operations, ensuring the successful integration of diverse frameworks within an organization’s CI/CD ecosystem.

In this project we will create a CI/CD pipeline for a react application. Find the project on github via the link below:

GitHub - marcrine-geek/BookAppFrontend: Book application frontend service using reactJS
Book application frontend service using reactJS. Contribute to marcrine-geek/BookAppFrontend development by creating an…
github.com

To edit the project and push the changes to github, you need to clone and push the project to your github repository. This will help you test the CI/CD pipeline.

Clone the project using the below command:

git clone https://github.com/marcrine-geek/BookAppFrontend
Create IAM roles

First, create an IAM role for EC2 and attach a policy that allows S3 access. This will enable EC2 to access S3.

Next, create an IAM role for codedeploy and attach AmazonEC2RoleforAWSCodeDeploy policy. This role will be attached to codedeploy for deployment on EC2 instance which has code deploy agent.


IAM roles for CI/CD pipeline
Launch EC2 instance

The next step, is to create an EC2 instance, in this project we will use an ubuntu server.


EC2 instance
Attach the IAM role we created for EC2 to allow S3 access as shown below


attach role to EC2
Connect to EC2 instance using the EC2 instance connect on the console to run updates, and create a new user, then install codedeploy agent.

Create a new user using the below command

sudo adduser ec2-user
The below link gives clear steps to install codedeploy agent on EC2 ubuntu server.

Install the CodeDeploy agent for Ubuntu Server
We recommend installing the CodeDeploy agent with AWS Systems Manager to be able to configure scheduled updates of the…
docs.aws.amazon.com

It is important to check the status of the codedeploy agent before moving to the next step. It should be active and running.

Create AWSCodePipeline, CodeBuild, CodeDeploy

AWS CodePipeline is a continuous integration and continuous delivery (CI/CD) service provided by Amazon Web Services (AWS). It is designed to automate and streamline the process of building, testing, and deploying applications or code changes across different stages of a software release workflow.

key features and components of CodePipeline:

Pipeline: A pipeline in AWS CodePipeline represents the workflow for your code changes. It consists of a series of stages, each representing a specific phase of the software release process. Stages can include actions like source code retrieval, build, test, deployment, and more.
Stages: A pipeline is divided into multiple stages, which represent different steps in the release process. Each stage can have one or more actions associated with it. For example, you might have stages for building, testing, and deploying your application.
Actions: Actions are the individual tasks performed within each stage. They can include tasks like source code retrieval from version control systems (GitHub, AWS CodeCommit), building code using build tools (AWS CodeBuild, Jenkins), running tests (AWS CodeBuild or third-party testing services), and deploying the application to servers or cloud services (AWS Elastic Beanstalk, AWS Lambda, Amazon ECS, EC2).
Artifacts: Artifacts are the output generated by actions. These could be compiled code, executables, configuration files, or any other files required for the subsequent stages or for deployment.
Integration with Other AWS Services: AWS CodePipeline can be integrated with various other AWS services such as AWS CodeBuild for building, AWS CodeDeploy for deployment, and AWS CodeCommit or GitHub for source code repositories. This tight integration allows for a seamless CI/CD experience within the AWS ecosystem.
Customization and Automation: CodePipeline allows you to customize your release process by defining your own pipeline stages and actions. It also supports automatic triggering of pipeline executions when changes are detected in your source code repository.
Visualization and Monitoring: AWS CodePipeline provides a visual representation of your pipeline, allowing you to track the progress of code changes as they move through various stages. This can help identify bottlenecks or issues in your release process.
Using AWS CodePipeline can significantly speed up the software delivery process, improve consistency in deployments, and help maintain high-quality code by automating testing and validation steps.

CodePipeline

Navigate to CodePipeline on AWS management console and click create pipeline.


Click next and connect to github repository


CodeBuild

The next step is to create a build project.


Click on create project and it will redirect you to a new window to create the build project.



The next step requires you to define the build specifications you will use for the build stage. There is two options, one is to create a buildspec.yml file in the root of your project, two is to insert build commands in the management console.

Let’s talk a little bit about the buildspec.yml file

The buildspec.yml file is a pivotal component of AWS CodeBuild, a service that compiles, tests, and deploys your code. The buildspec.yml file is used to define the build and deployment phases, along with the associated instructions and settings required to execute these phases.

significance of the buildspec.yml file in AWS CodeBuild:

Build Configuration: The primary purpose of the buildspec.yml file is to specify how your source code should be built, tested, and prepared for deployment. It acts as a blueprint that outlines the series of steps and commands necessary to transform your source code into a deployable artifact.
Declarative Definition: The buildspec.yml file uses a declarative syntax to define the build process. This means you list the tasks, commands, and settings in a structured format. AWS CodeBuild then follows these instructions precisely, ensuring consistent and repeatable builds.
Phases and Commands: Inside the buildspec.yml file, you define different build phases, such as installation, build, test, and deployment. Within each phase, you provide the specific commands and scripts that need to be executed. For example, you can specify the build tools to install, code compilation steps, unit testing commands, and more.
Environment Variables and Settings: The buildspec.yml file allows you to set environment variables that are available during the build process. This can include secrets, API keys, and other configuration values required by your code during the build or deployment.
Customization and Flexibility: The file provides a high degree of customization. You can configure the runtime environment, choose the programming language, set up caching to speed up builds, define post-build actions, and more, all within the same buildspec.yml file.
Integration with Source Control: The buildspec.yml file is often stored alongside your source code in your version control repository (Git). This enables tight integration with your source code management and automates the build process when changes are pushed to the repository.
Multi-Phase Workflows: For complex projects, the buildspec.yml file supports multi-phase workflows, enabling you to sequence tasks and steps in a controlled manner. This can include building multiple components, running various types of tests, and packaging artifacts for deployment.
In essence, the buildspec.yml file is the heart of AWS CodeBuild. It defines how your code is built and processed, making it a crucial part of your CI/CD pipeline for ensuring consistent, efficient, and reliable software builds and deployments.

Next step, add the name of the buildspec.yml file that is in our project directory.


Below is a sample buildspec.yml file for building the react application.

version: 0.2

phases:
  install:
    runtime-versions:
      nodejs: 18
   
    commands:
        # install npm
        - npm install
       
  build:
    commands:
        # run build script
        - npm run build
     
artifacts:
  # include all files required to run the application
  files:
    - public/**/*
    - src/**/*
    - package.json
    - appspec.yml
    - scripts/**/*
CodeDeploy

Before we create codedeploy, let’s talk about appspec.yml file

The appspec.yml file is a crucial component in AWS CodeDeploy, a service that automates application deployments to a variety of compute platforms, including Amazon EC2 instances, on-premises instances, AWS Lambda functions, and more. The appspec.yml file defines how CodeDeploy should manage the deployment lifecycle of your application.

The significance of appspec.yml file:

Deployment Lifecycle Instructions: The primary purpose of the appspec.yml file is to provide instructions to CodeDeploy on how to manage the deployment lifecycle of your application. It defines what actions CodeDeploy should perform before, during, and after deployment to ensure a smooth and controlled release process.
Pre- and Post-Deployment Hooks: Within the appspec.yml file, you can specify pre-deployment and post-deployment hooks. These hooks are scripts or commands that you want to run before and after deployment. This could include tasks such as stopping and starting services, migrating databases, or any other actions necessary to ensure the application's proper functioning.
Deployment Groups Configuration: The appspec.yml file also allows you to configure the behavior of deployment groups, which are sets of instances that receive deployments together. You can specify whether deployments should be performed in parallel or sequentially, how many instances should be deployed to simultaneously, and more.
File and Directory Mapping: In the appspec.yml file, you can specify how your application's files and directories should be mapped to the target environment during deployment. This includes defining source and destination paths for files, giving you fine-grained control over where files should be copied.
Permissions and Ownership: CodeDeploy often requires permissions to perform certain tasks during deployment, such as copying files or executing scripts. The appspec.yml file allows you to specify permissions and ownership settings for files and directories, ensuring that CodeDeploy has the necessary access.
Hooks for Different Deployment Types: Depending on the compute platform you’re deploying to (EC2 instances, Lambda functions), the appspec.yml file allows you to define deployment hooks specific to that platform. This flexibility enables you to tailor deployment processes to the unique requirements of each platform.
Overall, the appspec.yml file acts as a blueprint for CodeDeploy to orchestrate deployments according to your instructions. It provides the necessary information for CodeDeploy to understand how to handle your application, execute specific actions, manage files, and ensure consistent and reliable deployments.

below is an appspec.yml file which should be in the root of your project

version: 0.0

os: linux 

files:
  - source: /
    destination: /app
    overwrite: true

permissions:
  - object: /
    pattern: "**"
    owner: ec2-user
    group: ec2-user

hooks:

  BeforeInstall:
    - location: scripts/before_install.sh
      timeout: 300
      runas: root

  AfterInstall:
    - location: scripts/after_install.sh
      timeout: 300
      runas: root

  ApplicationStart:
    - location: scripts/start_server.sh     
      timeout: 300
      runas: root
Next, create code deploy application.

Navigate to code deploy and create an application with a deployment group


Select the service role we created for codedeploy.



Now, connect the codedeploy application and deployment group to codepipeline and click next to review and create the pipeline.


Creation process

You can view the codedeploy progress details, basically it contains the appspec.yml file lifecycle hooks


when all the events are successful in the deploy stage then it means our pipeline is a success.


You can navigate to S3 to see the bucket created to store the build artifacts


After successful creation of the pipeline, you can navigate to EC2 instance and copy the public IP to the browser to view the React application.
