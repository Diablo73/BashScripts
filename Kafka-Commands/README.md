# Kafka-Commands

## Produce a message

	sh /opt/homebrew/Cellar/kafka/3.4.0/libexec/bin/kafka-console-producer.sh --broker-list localhost:9092 --topic <TOPIC>

## Consume a message 

	sh /opt/homebrew/Cellar/kafka/3.4.0/libexec/bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic <TOPIC> --from-beginning

## List all topics

	sh /opt/homebrew/Cellar/kafka/3.4.0/libexec/bin/kafka-topics.sh --bootstrap-server localhost:9092 --list

## Create a topic

	sh /opt/homebrew/Cellar/kafka/3.4.0/libexec/bin/kafka-topics.sh --bootstrap-server localhost:9092 --create --replication-factor 1 -- partitions 1 --topic <TOPIC>

## Delete a topic

	sh /opt/homebrew/Cellar/kafka/3.4.0/libexec/bin/kafka-topics.sh --bootstrap-server localhost:9092 --delete --topic <TOPIC>

## List all groups

	sh /opt/homebrew/Cellar/kafka/3.4.0/libexec/bin/kafka-consumer-groups.sh --bootstrap-server localhost:9092 --list

## Describe a group

	sh /opt/homebrew/Cellar/kafka/3.4.0/libexec/bin/kafka-consumer-groups.sh --bootstrap-server localhost:9092 --describe --group <GROUP_NAME>
	sh /opt/homebrew/Cellar/kafka/3.4.0/libexec/bin/kafka-run-class.sh kafka.admin.ConsumerGroupCommand --bootstrap-server localhost:9092 --group <GROUP_NAME> --describe
