
#!/bin/sh
while true; do sleep 60 | tail -n+1 -f $1; done

