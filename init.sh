cd `dirname $0`
./resync.rb
gem generate_index
(crontab -l ; echo "45 * * * * `pwd`/update.sh") | crontab -
