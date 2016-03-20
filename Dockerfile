from alpine

copy	myip /myip

run	chmod +x myip && \
	apk update && \
	apk add curl && \
	rm /var/cache/apk/* 


cmd	./myip
