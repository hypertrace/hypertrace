#!/bin/sh
TIMEOUT=15
usage() {
  exitcode="$1"
  cat << USAGE >&2
Usage:
  $cmdname [-h host] [-p port] [-t timeout]
  -h HOST | --host=host               Hostname
  -p PORT | --port=port               Port
  -t TIMEOUT | --timeout=timeout      Timeout in seconds, zero for no timeout
USAGE
  exit "$exitcode"
}
wait_for() {
  printf "Checking $HOST:$PORT"
  start_ts=$(date +%s)
  for i in `seq $TIMEOUT` ; do
    nc -z "$HOST" "$PORT" > /dev/null 2>&1
    result=$?
    if [ $result -eq 0 ] ; then
      end_ts=$(date +%s)
      printf "\nSocket address ($HOST:$PORT) is available after $((end_ts - start_ts)) seconds.\n"
      return 0
    fi
    printf "."
    sleep 1
  done
  printf "\nSocket address ($HOST:$PORT) check timed out!\n" >&2
  return 1
}
while [ $# -gt 0 ]
do
  case "$1" in
    -h)
    HOST="$2"
    if [ "$HOST" = "" ]; then break; fi
    shift 2
    ;;
    --host=*)
    HOST="${1#*=}"
    shift 1
    ;;
    -p)
    PORT="$2"
    if [ "$PORT" = "" ]; then break; fi
    shift 2
    ;;
    --port=*)
    PORT="${1#*=}"
    shift 1
    ;;
    -t)
    TIMEOUT="$2"
    if [ "$TIMEOUT" = "" ]; then break; fi
    shift 2
    ;;
    --timeout=*)
    TIMEOUT="${1#*=}"
    shift 1
    ;;
    --)
    shift
    break
    ;;
    --help)
    usage 0
    ;;
    *)
    echo "Unknown argument: $1" >&2
    usage 1
    ;;
  esac
done

if [ "$HOST" = "" -o "$PORT" = "" ]; then
  echo "Error: you need to provide a host and port to test." >&2
  usage 2
fi

wait_for
WAITFORIT_RESULT=$?

if [ "$*" != "" ]; then
    if [ $WAITFORIT_RESULT -ne 0 ]; then
        exit $WAITFORIT_RESULT
    fi
    exec "$@"
else
    exit $WAITFORIT_RESULT
fi