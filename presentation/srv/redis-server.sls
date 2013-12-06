redis-server:
  pkg:
    - installed
  service:
    - running

packages:
  pkg.installed:
    - names:
      - iotop
