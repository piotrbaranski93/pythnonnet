#!/bin/bash
IsCentOS=false
IsScientificLinux=false
OSType=$(cat /etc/redhat-release | awk '{print tolower($0)}')
if [[ "$OSType" == *"centos"* ]]; then
	IsCentOS=true	
elif [[ "$OSType" == *"scientific"*  ]]; then
	IsScientificLinux=true
fi
if $IsCentOS; then
	echo "CentOS Installing RabbitMQ Server"
	#Install Erlang
	wget http://packages.erlang-solutions.com/erlang-solutions-1.0-1.noarch.rpm
	sudo rpm -Uvh erlang-solutions-1.0-1.noarch.rpm
	sudo yum -y install erlang socat logrotate
	#Install RabbitMQ
	wget https://github.com/rabbitmq/rabbitmq-server/releases/download/v3.8.35/rabbitmq-server-3.8.35-1.el8.noarch.rpm
	sudo rpm --import https://www.rabbitmq.com/rabbitmq-signing-key-public.asc
	sudo rpm -Uvh rabbitmq-server-3.8.35-1.el8.noarch.rpm
	sudo systemctl start rabbitmq-server
	sudo systemctl enable rabbitmq-server
elif $IsScientificLinux; then
	echo "ScientificLinux Installing RabbitMQ Server"
	#Install Erlang
	read -p "Continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
	wget https://dl.fedoraproject.org/pub/epel/7/x86_64/Packages/e/epel-release-7-14.noarch.rpm 
	#wget http://packages.erlang-solutions.com/erlang-solutions-1.0-1.noarch.rpm
	read -p "Continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
	sudo rpm -Uvh epel-release-7-14.noarch.rpm
	#sudo rpm -Uvh erlang-solutions-1.0-1.noarch.rpm
	read -p "Continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
	sudo yum install erlang
	#sudo yum -y install erlang socat logrotate
	read -p "Continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
	#Install RabbitMQ
	wget https://github.com/rabbitmq/rabbitmq-server/releases/download/v3.8.35/rabbitmq-server-3.8.35-1.el8.noarch.rpm
	read -p "Continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
	sudo rpm --import https://www.rabbitmq.com/rabbitmq-signing-key-public.asc
	read -p "Continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
	sudo rpm -Uvh rabbitmq-server-3.8.35-1.el8.noarch.rpm
	read -p "Continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
	sudo service start rabbitmq-server
	read -p "Continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
	sudo service enable rabbitmq-server
fi 
