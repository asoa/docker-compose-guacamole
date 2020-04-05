### docker-compose project to create an apache guacamole clientless remote desktop gateway [project site](https://guacamole.apache.org)

---
1. guac.sh main() builds the directory structure, pulls the images and initiates the mysql database 
2. change the password for the mysql db in both *.env files in mysql/ and guacamole/
3. change the password for the guacamole user to the password set in #2
4. run docker-compose up and then browse to localhost:8080/guacamole and login in with guacadmin:guacadmin
