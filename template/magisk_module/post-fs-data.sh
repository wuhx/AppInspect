#!/system/bin/sh
MODDIR=${0%/*}

if [ -z "$SHELL" ]; then
  export SHELL=sh
fi
export CLASSPATH=$MODDIR/Agentd.apk
cd $MODDIR
flock "module.prop" -c "/system/bin/app_process -Djava.class.path=Agentd.apk /system/bin --nice-name=agentd com.coudmonad.agentd.Main $$ $(magisk -V) $(magisk --path)" 2>&1 | xargs log -t "Riru"
