
## The Purpose Of The Project

The Purpose of this project is to efficiently provision secure, organized, highly available, highly scalable, and fault-tolerant infrastructures within the AWS environment using Terraform Modules. Terraform Modules streamline the process of infrastructures provisioning and management on AWS.

The projects establishes software design pattern that separates an application into three distinct layers- the prestation(frontend) layer, the application, logic (backend) layer, and the database layer.This separation enhances the application scalability, maintainability, and flexibility. 

**Prestation layer**: The user interface on application sits on this. Its is layer where customers see and interact with application.

**Backend layer**: The backend layer cordinates between the frontend layer and the darabase layer. It's also a layer where developers write application in Jarva, Python, Golanguage, etc.

**Database layer**: This layer stores the description, images, pricing, and other attributes of products displayed in the presentation layer.



## Amazon Virtual Private Cloud(VPC): 
It is a logical section of the AWS Cloud where you can deploy and run AWS resources. It allows you to create a private network in the cloud, provide control over the virtual network environment, including Ip address ranges or cidr blocks, subnet, configuration of route tables, and network gateways.