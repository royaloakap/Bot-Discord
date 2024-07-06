@echo off
echo :: Installing/Updating Bundler
call gem install bundler
echo :: Installing/Udating Bundle..
call bundle install
echo :: Updating BotRuby..
git pull
echo Done! Please load run.bat if successful!
pause