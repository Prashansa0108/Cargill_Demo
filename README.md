# Cargill_Demo

Below is the file structure,
src -> source code
userdata -> To be run inside EC2 while launching (Install Docker and Run container with image)
Dockerfile -> To create image with source code and further to create container
provider.tf -> It contains secret to launch the configuration
main.tf -> To create other supporting resources for the EC2 instance
webapp.tf -> To create EC2 instance and supporting security group
variable.tf -> To define variables 


Steps to run the code,
-> To run the code please put your access_key and secret_key 
-> Type terraform apply from your local machine
-> This will create your EC2 instance inside which the bootstrap script will run (userdate/web.sh)
-> The script will install Docker on the instance, then the image will be created (Using Dockerfile), then the container will be created
-> Once the EC2 is up, it will get a public ip address, please take the ip address and open the browser, in browser type,
<public_ip>:<port>, in our case we are using Nginx container and default port is 80.

I just created the simple application to print "Cargill Demo" in the browser because no usecase was given for the application, we can add further code as per the requirement to the src folder.

For deployment part we can use CodeCommit, I didn't get much time to implement that part. 
We can push our code to CodeCommit and write a CFT to create CodePipeline, once created, we can do release change. (Build tool will also be required to make the application work)

We can create another terraform to create IAM_Role, CodeDeploy in order to create CI/CD pipeline.
