#!/bin/sh

FILES=`find /etc/php -iname www.conf -exec echo {} \;`
NEW_USER="$1"

[ -z "$NEW_USER" ] && { echo "Must supply a username as the first param" ; exit 1; }

# Update php-fpm confs.
for file in ${FILES}; do
  sudo sed -i "s/user = www-data/user = $NEW_USER/g" ${file}
  sudo sed -i "s/listen.owner = www-data/listen.owner = $NEW_USER/g" ${file}
done

# Restart apache and php-fpm
sudo service apache2 restart && sudo service php7.2-fpm restart

echo "Changed PHP-FPM User to: $NEW_USER"
