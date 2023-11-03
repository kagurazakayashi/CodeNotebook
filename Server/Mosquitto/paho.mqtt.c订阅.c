#include <stdio.h>
#include <string.h>
#include "MQTTClient.h"

void delivered(void *context, MQTTClient_deliveryToken dt)
{
    printf("[MQTT] Message with token value %d delivery confirmed\n", dt);
    deliveredtoken = dt;
}

int msgarrvd(void *context, char *topicName, int topicLen, MQTTClient_message *message)
{
    printf("[MQTT MSG %llu] (%ld) %s : %.*s\n", total, message->payloadlen, topicName, message->payloadlen, message->payload);
    return 1;
}

int quit(int rc) {
    printf("[MQTT EXIT] Unsubscribe \"%s\" ...\n", mqttTopicNow);
    if ((rc = MQTTClient_unsubscribe(client, mqttTopicNow)) != MQTTCLIENT_SUCCESS)
    {
        printf("[MQTT ERR] Failed to unsubscribe, return code %d\n", rc);
        rc = EXIT_FAILURE;
    }
    printf("[MQTT EXIT] Disconnect ...\n");
    if ((rc = MQTTClient_disconnect(client, 10000)) != MQTTCLIENT_SUCCESS)
    {
        printf("[MQTT ERR] Failed to disconnect, return code %d\n", rc);
        rc = EXIT_FAILURE;
    }
    MQTTClient_destroy(&client);
}

void connlost(void *context, char *cause)
{
    printf("\n[MQTT ERR] Connection lost\n");
    printf("     cause: %s\n", cause);
    client = NULL;
    quit(EXIT_FAILURE);
}

int main(int argc, char* argv[])
{
    // LINK MQTT
    printf("[MQTT] Connecting %s ...\n", mqttHost);
    if ((rc = MQTTClient_create(&client, mqttHost, mqttId,
        MQTTCLIENT_PERSISTENCE_NONE, NULL)) != MQTTCLIENT_SUCCESS)
    {
        printf("[MQTT ERR] Failed to create client, return code %d\n", rc);
        return quit(EXIT_FAILURE);
    }
    if ((rc = MQTTClient_setCallbacks(client, NULL, connlost, msgarrvd, delivered)) != MQTTCLIENT_SUCCESS)
    {
        printf("[MQTT ERR] Failed to set callbacks, return code %d\n", rc);
        return quit(EXIT_FAILURE);
    }
    conn_opts.keepAliveInterval = 20;
    conn_opts.cleansession = 1;
    if (strlen(mqttUser) > 0 && strlen(mqttPwd) > 0) {
        printf("[MQTT] Login \"%s\" ...\n", mqttUser);
        conn_opts.username = mqttUser;
        conn_opts.password = mqttPwd;
    }
    if ((rc = MQTTClient_connect(client, &conn_opts)) != MQTTCLIENT_SUCCESS)
    {
        printf("[MQTT ERR] Failed to connect, return code %d\n", rc);
        return quit(EXIT_FAILURE);
    }
    printf("[MQTT] for client \"%s\" using QoS %d .\n", mqttId, mqttQOS);

    // MQTT Subscribe
    char *mqttTopicNow;
    for (i = 0; i < 100; i++)
    {
        mqttTopicNow = mqttTopic[i];
        if (strlen(mqttTopicNow) == 0) break;
        printf("[MQTT] Subscribing to topic \"%s\" ...\n", mqttTopicNow);
        if ((rc = MQTTClient_subscribe(client, mqttTopicNow, mqttQOS)) != MQTTCLIENT_SUCCESS)
        {
            printf("[MQTT ERR] Failed to subscribe, return code %d\n", rc);
            return quit(EXIT_FAILURE);
        }
    }
    return 1;
}