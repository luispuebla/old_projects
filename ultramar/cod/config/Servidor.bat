@echo off
echo Ejecutando Servidor FTP
start rmiregistry
start java -Djava.security.policy=policy.pcy frontEnd.servidor.FTPServiceServer