# AWS WITH TERRAFORM

## Using Terraform to create a fully functional VPC, RDS and Elastic Beanstalk to deploy a JAVA SPRING BOOT application.

## Steps

[url]: https://www.linkedin.com/pulse/quick-setup-aws-vpc-elastic-beanstalk-rds-deploy-java-opeyemi-alabi-swdsf

Check the steps 👉 [here][url]

Make the script executable: chmod +x install_tools.sh

Run the script to install the tools: ./install_tools.sh

Verify the installation by checking the versions of the installed tools: aws --version; terraform -v

Connect to AWS: aws configure

terraform init -upgrade

Створити нову версію
aws elasticbeanstalk create-application-version --application-name teachua-app --version-label v1.0 --source-bundle S3Bucket=teachua-bucket-new,S3Key=dev.war

Оновити середовище 
aws elasticbeanstalk update-environment --environment-name teachua-env --version-label v1.0

Переглянути статус середовища: Виконайте команду aws elasticbeanstalk describe-environments --environment-names teachua-env і перевірте поле Status. Воно повинно бути "Ready".

Перевірити логи: Використайте aws elasticbeanstalk request-environment-info --environment-name teachua-env --info-type tail для отримання логів, а потім aws elasticbeanstalk retrieve-environment-info --environment-name teachua-env --info-type tail для їх перегляду.

Тестування API: Введіть URL вашого API, наприклад, http://teachua-app.us-east-1.elasticbeanstalk.com/dev/api/cities, у браузері або за допомогою Postman, щоб перевірити, чи повертає він очікуваний результат.

aws elasticbeanstalk create-application-version \
  --application-name teachua-app \
  --version-label v2.1 \
  --source-bundle S3Bucket="teachua-bucket-new",S3Key="dev2.war"

  eb-backend-bucket

  aws elasticbeanstalk list-available-solution-stacks

  ssh -i "/home/codespace/.ssh/web02_key" ec2-user@ec2-3-239-226-34.compute-1.amazonaws.com

  mysql -h teachua-db.ctegro5wnfvo.us-east-1.rds.amazonaws.com -u user -p

  sudo yum update -y
  sudo yum install mysql-community-client -y


  sudo rpm -Uvh https://repo.mysql.com/mysql80-community-release-el7.rpm
  sudo yum update -y
  sudo yum install mysql-community-client -y

  sudo yum install docker -y
  sudo service docker start
  docker run -it --rm mysql:8.0 mysql -h teachua-db.ctegro5wnfvo.us-east-1.rds.amazonaws.com -u user -p

ps aux | grep tomcat
