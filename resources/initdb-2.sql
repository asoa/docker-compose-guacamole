CREATE USER 'guacamole' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON guacamole.* TO 'guacamole';
FLUSH PRIVILEGES;
