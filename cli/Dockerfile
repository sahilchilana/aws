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
RUN apt install jq
COPY "entrypoint.sh" "/entrypoint.sh"
ENTRYPOINT ["/entrypoint.sh"]
CMD ["help"]
