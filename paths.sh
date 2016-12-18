export PATH=${PATH}:~/Android/Sdk/tools/
export PATH=${PATH}:~/Android/Sdk/platform-tools/
export PATH=${PATH}:/opt/pypy3/bin/
export PATH=${PATH}:~/.bin/

#Ruby
GEM_HOME=$(ls -t -U | ruby -e 'puts Gem.user_dir')
GEM_PATH=$GEM_HOME  
export PATH=$PATH:$GEM_HOME/bin
export PATH=${PATH}:"$(ruby -e 'print Gem.user_dir')/bin"
