#Grails Container

This docker image includes Java 8, Grails 3.2.8 & Python 3 for use in developing Grails applications (with the Grails cli as the endpoint).

## Usage

### Default Behavior
By defaut, running this image without any command will run `grails -version` in the /app directory. Thus, you should mount your project in /app. For example, a more interesting command would be test-running your app.

```bash
# For files on the dockerhost
docker run --rm -v /path/to/your/project:/app:rw -p 80:8080 --name grails explorite/grails3-python grails run-app

# For a data container
docker run --rm --link data-container-name:data -p 80:8080 --name grails explorite/grails3-python grails run-app
```

### Versatility
Of course, you can use any command here, and take notice that `grails` is the entrypoint. So, to create an application, run the following:

```bash
docker run --rm -v /path/to/dir:/app:rw --name grails explorite/grails3-python create-app helloworld
```

### Interactive Mode
Downloading a whole bunch of things each time you run the container is a pain -- not to mention a huuge bandwidth sink ( for everyone else stuck in 1995 internet with me ). A nice feature of Grails is its interactive mode. Also useful if you find yourself starting a grails container frequently, you can set the docker switches -i and -t and the grails switch `--interactive` (see example). This overrides the default CMD (`-version`) if you didn't change it.

```bash
docker run -it --rm -v /path/to/project:/app:rw --name grails explorite/grails3-python --interactive
```

### Building On This Container

Obviously, `grails -version` is not a very interesting command. So, when want to customize or get annoyed with changing your project's user and group, you can build off of this image and tweak all the settings, install more packages, etc:

```bash
FROM explorite/grails3-python
MAINTAINER your-name-here <email@you.com>

# In case someone loses the Dockerfile
RUN rm -rf /etc/Dockerfile
ADD Dockerfile /etc/Dockerfile

# Add your desired user and group
RUN groupadd your-group-name
RUN useradd -s /bin/bash -m -d /app -g your-group-name your-user-name

# Set your desired user as default
USER your-user-name

# Whatever default behavior you want
ENTRYPOINT ["grails"]
CMD ["run-app"]
```

## Get the Image

To build this image yourself, run...
 
```bash
docker build github.com/explorite/grails-python-docker
```

Or, you can pull the image from the central docker repository by using... 

```bash
docker pull explorite/grails3-python
```
