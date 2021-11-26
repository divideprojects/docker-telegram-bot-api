mkdir /static-bash
cd /tmp

# identify arch
uname_machine=$(uname -m)
if [ "$uname_machine" = "amd64" ] || [ "$uname_machine" = "x86_64" ]; then
  arch="x86_64"
elif [ "$uname_machine" = "arm64" ] || [ "$uname_machine" = "aarch64" ]; then
  arch="aarch64"
else
  exit 1
fi

wget "https://github.com/robxu9/bash-static/releases/latest/download/bash-linux-${arch}"
chmod +x bash-linux-*
cp bash-linux-* "/static-bash/bash"
