NAME=homeassistant
IMAGE="homeassistant/home-assistant:stable"

all: help

upgrade: update

backup:
	@bash ./backup.sh
status:
	@echo -n "$(NAME) is "
	@docker ps |grep $(IMAGE) > /dev/null || echo -n "NOT "
	@echo "running"
stop:
	@echo "Stopping $(NAME)"
	@docker stop $(NAME) && echo "Stopped" || echo "Failed"
rm:
	@echo "Removing $(NAME)"
	@docker rm $(NAME) && echo "Removed" || echo "Failed"
start:
	@echo "Starting $(NAME)"
	@docker start $(NAME) && echo "Started" || echo "Failed"
run:
	@echo "Starting new $(NAME)"
	@docker run -d \
	--name $(NAME) \
	--privileged \
	--restart=unless-stopped \
	-e TZ=Europe/Helsinki \
	-v /opt/homeassistant/config:/config \
	--network=host \
	$(IMAGE) && echo "Started" || echo "Failed"
update:
	@./run.sh update

restart:
	@echo "Restarting $(NAME)"
	@docker restart homeassistant && echo "Restarted" || echo "Failed"

clean:
	@docker rmi $$(docker images -f "dangling=true" -q)

help:
	@echo "make start|stop|restart|rm|update"
