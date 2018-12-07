#! /bin/bash

echo "   :::     ::: ::::::::::: :::::::: ::::::::::: ::::::::  ::::::::: "
echo "  :+:     :+:     :+:    :+:    :+:    :+:    :+:    :+: :+:    :+: "
echo " +:+     +:+     +:+    +:+           +:+    +:+    +:+ +:+    +:+  "
echo "+#+     +:+     +#+    +#+           +#+    +#+    +:+ +#++:++#:    "
echo "+#+   +#+      +#+    +#+           +#+    +#+    +#+ +#+    +#+    "
echo "#+#+#+#       #+#    #+#    #+#    #+#    #+#    #+# #+#    #+#     "
echo " ###     ########### ########     ###     ########  ###    ###      "

# All passwd entries with non /bin/false or /bin/true login.
echo
echo "#####################"
echo "Accounts with shells:"
echo "#####################"
awk 'BEGIN{FS=":";} {print "   ",$1,$7;}' /etc/passwd | egrep -v /bin/false\|/usr/sbin/nologin\|/sbin/nologin\|/bin/true

# All shadow entries with non * password entry
echo
echo "########################"
echo "Accounts with passwords:"
echo "########################"
awk 'BEGIN{FS=":";} {print "   ",$1,$2;}' /etc/shadow | grep -v ' \*' | grep -v ' \!'
echo

# Store home dires in /tmp/home_dirs
awk 'BEGIN{FS=":";} {print $6;}' /etc/passwd >/tmp/home_dirs

# history and bash history files
echo
echo "##############"
echo "History files:"
for x in $(cat /tmp/home_dirs); do
    for y in .bash_history .history; do
         if [ -f $x/$y ]; then
             echo ---
             echo $x/$y -- History file
             cat $x/$y
             echo ---
             echo
         fi
    done
done
echo "##############"
echo

# All .ssh/authorized_keys files
echo
echo "####################################"
echo "Accounts with authorized_keys files:"
echo "####################################"
for x in $(cat /tmp/home_dirs); do
    if [ -f $x/.ssh/authorized_keys ]; then
        echo "--- $x"; cat $x/.ssh/authorized_keys; echo ---;
    fi
done
echo


# All .bak files in /var/www
if [ -e /var/www ]; then
    echo
    echo "#########################"
    echo "Backup files in /var/www:"
    echo "#########################"
    echo
    find /var/www | egrep ~\$\|.bak\$\|.orig\$\|[._]*.s[a-v][a-z]\$\|[._]*.sw[a-p]\$\|[._]s[a-v][a-z]\$\|[._]sw[a-p]\$
    echo
else
    echo "#####################"
    echo "No /var/www directory"
    echo "#####################"
fi

# Contents of all .history files

# robots.txt in /var/www and /var/www/html
# All htaccess, .htaccess, htpasswd, and .htpasswd in /var/www/...

# All set-user executables  (with dates)
# All set-group executables  (with dates)