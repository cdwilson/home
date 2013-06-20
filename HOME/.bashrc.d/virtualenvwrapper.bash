# ----------------------------------------------------------------------
# virtualenvwrapper
# ----------------------------------------------------------------------

if [ -r "/opt/local/bin/virtualenvwrapper.sh-2.7" ]; then
  . "/opt/local/bin/virtualenvwrapper.sh-2.7"
fi

alias v=workon
alias v.deactivate=deactivate
alias v.d=deactivate
alias v.m='mkvirtualenv --no-site-packages'
alias v.mk='mkvirtualenv'
alias v.mk_bare='mkvirtualenv --no-setuptools --no-pip --no-site-packages'
alias v.mk_bare_no_download='mkvirtualenv --no-setuptools --no-pip --no-site-packages --never-download'
alias v.mk_with_setuptools='mkvirtualenv --setuptools'
alias v.mk_with_distribute='mkvirtualenv --distribute'
alias v.mk_with_site_packages='mkvirtualenv --system-site-packages'
alias v.rm=rmvirtualenv
alias v.switch=workon
alias v.ls=workon
alias v.add_to_virtualenv=add2virtualenv
alias v.cd_site_packages=cdsitepackages
alias v.cd=cdvirtualenv
alias v.ls_site_packages=lssitepackages
