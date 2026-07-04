
#!/bin/bash

# 既存の Polybar プロセスを終了
killall -q polybar

# すべての Polybar インスタンスを再起動
polybar example &

# polybar pam1 &

echo "Polybar launched..."

