USUARIO_REF=$1
LISTA=$2
CLAVE=$(sudo grep "^$USUARIO_REF:" /etc/shadow | awk -F':' '{print $2}')

ANT_IFS=$IFS
IFS=$'\n'

for i in $(cat $LISTA | grep -v ^#)
do
    USUARIO=$(echo $i | awk -F',' '{print $1}')
    GRUPO=$(echo $i | awk -F',' '{print $2}')
    HOME_DIR=$(echo $i | awk -F',' '{print $3}')
 
    sudo groupadd -f $GRUPO
    sudo useradd -m -d $HOME_DIR -s /bin/bash -g $GRUPO -p "$CLAVE" $USUARIO
done

IFS=IFS=$ANT_IFS
