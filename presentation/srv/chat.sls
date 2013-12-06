dev:
  user.present:
    - fullname: Developer
    - home: /home/dev

https://github.com/facebook/tornado.git:
  git.latest:
    - target: /home/dev/tornado
    - user: dev
    - revision: master
  require:
    - pkg: git
    - user: dev

nginx:
  pkg:
    - installed
  service:
    - running
    - watch:
      - file: /etc/nginx/nginx.conf

/etc/nginx/nginx.conf:
  file.managed:
    - source: salt://nginx.conf

/etc/init/chat.conf:
  file.managed:
    - source: salt://chat_upstart.conf

req-packages:
  pkg.installed:
    - names:
      - git
      - python-dev
      - python-virtualenv

/home/dev/venv:
  virtualenv.managed:
    - system_site_packages: False
    - user: dev
    - runas: dev
    - requirements: salt://requirements.txt
  require:
    - pkg: python-virtualenv
    - user: dev

chat:
  service:
    - running
  require:
    - user: dev
    - pkg: git    
