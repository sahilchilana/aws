FROM python:3-stretch

LABEL name="aws"
LABEL version="1.0.0"
LABEL repository="http://github.com/actions/aws"
LABEL homepage="http://github.com/actions/aws"

LABEL maintainer="GitHub Actions <support+actions@github.com>"
LABEL com.github.actions.name="GitHub Action for AWS"
LABEL com.github.actions.description="Wraps the aws CLI to enable common AWS commands."
LABEL com.github.actions.icon="box"
LABEL com.github.actions.color="yellow"
COPY LICENSE README.md THIRD_PARTY_NOTICE.md /

ENV DOCKERVERSION=18.06.1-ce
RUN apt-get install python2.7
RUN pip install BeautifulSoup4
RUN pip install selenium
RUN apt-get update && \
  apt-get install -y --no-install-recommends curl groff jq && \
  apt-get -y clean && apt-get -y autoclean && apt-get -y autoremove && \
  curl -fsSLO https://github.com/kubernetes-sigs/aws-iam-authenticator/releases/download/v0.3.0/heptio-authenticator-aws_0.3.0_linux_amd64 && \
  mv heptio-authenticator-aws_0.3.0_linux_amd64 /usr/local/bin/aws-iam-authenticator && \
  chmod +x /usr/local/bin/aws-iam-authenticator && \
  curl -fsSLO https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKERVERSION}.tgz && \
  tar xzvf docker-${DOCKERVERSION}.tgz --strip 1 \
                 -C /usr/local/bin docker/docker && \
  rm docker-${DOCKERVERSION}.tgz && \
  rm -rf /var/lib/apt/lists/* && \
  pip install --upgrade pip && \
  pip install setuptools awscli
RUN apt install jq
RUN apt-get install -y libglib2.0-0=2.50.3-2 \
    libnss3=2:3.26.2-1.1+deb9u1 \
    libgconf-2-4=3.2.6-4+b1 \
    libfontconfig1=2.11.0-6.7+b1
COPY "entrypoint.sh" "/entrypoint.sh"
ENTRYPOINT ["/entrypoint.sh"]
CMD ["help"]
