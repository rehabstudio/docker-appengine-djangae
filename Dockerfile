FROM rehabstudio/appengine:wheezy
MAINTAINER +rehabstudio <devops@rehabstudio.com>

ADD . /src
WORKDIR /src

RUN pip install -r requirements.txt -t sitepackages

EXPOSE 8000 8001 8002
CMD ["python", "manage.py", "runserver"]

ONBUILD ADD ./requirements.txt .
ONBUILD RUN pip install -r requirements.txt -t sitepackages

ONBUILD ADD ./*.yaml /src/
ONBUILD ADD ./app /src/app
