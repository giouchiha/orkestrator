# Funcion para enviar historial de comandos de bash a syslog.
function cmd2syslog
{
   declare COMMAND
   COMMAND=$(fc -ln -0)
   logger -p local1.notice -t bash -i -- "${USER} : ${COMMAND}"
}
trap cmd2syslog DEBUG
