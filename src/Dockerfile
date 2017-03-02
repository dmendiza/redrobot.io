FROM fedora:25

LABEL maintainer "Douglas Mendizábal <douglas@redrobot.io>"

RUN dnf upgrade -y
RUN pip3 install django gunicorn

WORKDIR /srv/www
ADD manage.py manage.py
ADD blog/*.py blog/
ADD blog/migrations/*.py blog/migrations/
ADD redrobot/*.py redrobot/

EXPOSE 8000
CMD ["gunicorn", "-b", "0.0.0.0", "--access-logfile", "-", "redrobot.wsgi:application"]
