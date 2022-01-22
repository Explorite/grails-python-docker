FROM mozart/grails:3
MAINTAINER Adi Pellumbi <adi.pellumbi@explorite.com>

# Download python3
RUN apt-get update
RUN apt-get install -y python-pip
RUN apt-get install -y python3
RUN pip install boto3==1.3.0

# Create App Directory
RUN mkdir /app

# Set Workdir
WORKDIR /app

# Set Default Behavior
ENTRYPOINT ["grails"]
