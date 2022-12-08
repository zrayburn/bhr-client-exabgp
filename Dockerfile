FROM python:3.8
ENV PYTHONUNBUFFERED 1
RUN mkdir /code
WORKDIR /code

RUN curl -L https://github.com/Exa-Networks/exabgp/archive/4.2.21.tar.gz | tar zx

ADD requirements.txt /code/
RUN pip install -r requirements.txt
ADD . /code/
RUN pip install .

CMD /code/examples/start_inside_docker
