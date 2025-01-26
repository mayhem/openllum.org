FROM ubuntu:22.04

RUN apt-get update \
    && apt-get install -y --no-install-recommends build-essential python3-dev python3-pip \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /code
WORKDIR /code

RUN pip3 install setuptools uwsgi

RUN mkdir /code/openllum.org
WORKDIR /code/openllum.org

COPY requirements.txt /code/openllum.org/
RUN pip3 install --no-cache-dir -r requirements.txt

RUN apt-get purge -y build-essential && \
    apt-get autoremove -y && \
    apt-get clean -y

# Now install our code, which may change frequently
COPY . /code/openllum.org

CMD uwsgi --gid=www-data --uid=www-data --http-socket :3031 \
          --vhost --module=server --callable=app --chdir=/code/openllum.org \
          --enable-threads --processes=15
