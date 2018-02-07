#¡/bin/sh
echo Ejecutando Servidor FTP
rmiregistry &
java -Djava.security.policy=policy.pcy frontEnd.servidor.FTPServiceServer &
