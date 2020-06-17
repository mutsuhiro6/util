function encrypt_password() {
  plain_password=$1
  if [ "$(uname)" == 'Darwin' ]; then
    system_uuid=`system_profiler SPHardwareDataType |grep "Hardware UUID: [0-9A-Z]\{8\}-[0-9A-Z]\{4\}-[0-9A-Z]\{4\}-[0-9A-Z]\{4\}-[0-9A-Z]\{12\}" | sed -e 's/^.*Hardware UUID: \([0-9A-Z]\{8\}-[0-9A-Z]\{4\}-[0-9A-Z]\{4\}-[0-9A-Z]\{4\}-[0-9A-Z]\{12\}\).*$/\1/g'`
  elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
    system_uuid=`sudo /usr/sbin/dmidecode -s system-uuid`
  else
    echo Unsupported system.
    exit
  fi
  encrypted_password=`echo "$plain_password" | openssl enc -e -pbkdf2 -base64 -k "$system_uuid"`
  echo $encrypted_password
}

function decrypt_password() {
  encrypted_password=$1
  if [ "$(uname)" == 'Darwin' ]; then
    system_uuid=`system_profiler SPHardwareDataType |grep "Hardware UUID: [0-9A-Z]\{8\}-[0-9A-Z]\{4\}-[0-9A-Z]\{4\}-[0-9A-Z]\{4\}-[0-9A-Z]\{12\}" | sed -e 's/^.*Hardware UUID: \([0-9A-Z]\{8\}-[0-9A-Z]\{4\}-[0-9A-Z]\{4\}-[0-9A-Z]\{4\}-[0-9A-Z]\{12\}\).*$/\1/g'`
  elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
    system_uuid=`sudo /usr/sbin/dmidecode -s system-uuid`
  else
    echo Unsupported system.
    exit
  fi
  plain_password=`echo "$encrypted_password" | openssl enc -d -pbkdf2 -base64 -k "$system_uuid"`
  echo $plain_password
}
