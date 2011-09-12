cd `dirname $0`
./resync.rb
gem generate_index
(crontab -l ; echo "0 4 * * * `pwd`/update.sh") | crontab -
