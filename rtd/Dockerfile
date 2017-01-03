FROM webplates/readthedocs:latest

# Add the neccessary packages so that Python can build app dependencies.
RUN apk --update add linux-headers gcc musl-dev python-dev py-libxml2 libxml2-dev libxslt-dev cython cython-dev libxml2 libxml2-utils

# Add the requirements so that PIP can install everything.
ADD root/requirements.txt /requirements.txt

# PIP, please install everthing.
RUN pip install -r /requirements.txt

# Clone the readthedocs repository, and build the static files.
RUN mkdir -p /home/docs/checkouts && \
    cd /home/docs/checkouts && \
    git clone https://github.com/rtfd/readthedocs.org.git --recurse-submodules && \
    cd ./readthedocs.org && \
    python manage.py collectstatic --noinput

# Add the remaining files we need
ADD root /
