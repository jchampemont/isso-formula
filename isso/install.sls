{% from 'ghost/map.jinja' import isso with context %}

isso.dependencies:
  pkg.installed:
    - pkgs:
      - supervisor
      - python-setuptools
      - python-virtualenv
      - build-essential
      - python2.7-dev

{{ isso.path }}:
  file.directory:
    - user: {{ isso.user }}
    - group: {{ isso.user }}
    - dir_mode: 755
  virtualenv.managed:
    - user: {{ isso.user }}
    - cwd: {{ isso.path }}
    - pip_pkgs:
      - isso

{{ isso.path }}/etc/isso.conf:
  file.managed:
    - source: salt://isso/files/isso.conf
    - makedirs: True
    - user: {{ isso.user }}
    - group: {{ isso.user }}
    - mode: 644
    - template: jinja

/etc/supervisor/conf.d/isso.conf:
  file.managed:
    - source: salt://isso/files/isso.supervisord.conf
    - user: root
    - group: root
    - mode: 644
    - template: jinja

isso:
  supervisord.running:
    - update: True
    - user: root
    - watch:
      - pkg: isso.dependencies
      - file: {{ isso.path }}
      - virtualenv: {{ isso.path }}
      - file: {{ isso.path }}/etc/isso.conf
      - file: /etc/supervisor/conf.d/isso.conf