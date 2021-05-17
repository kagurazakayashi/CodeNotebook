#include <stdio.h>
#include "hiredis.h"
int main(int argc, char* argv[])
{
    // LINK REDIS
    printf("[REDIS] Connecting %s:%d ...\n", redisHost, redisPort);
    struct timeval timeout = { 5, 500000 }; //3.5s
    conn = redisConnectWithTimeout(redisHost, redisPort, timeout);
    if(conn == NULL || conn->err) {
        printf("[REDIS ERR] Connection error: %s\n",conn->errstr);
        return quit(EXIT_FAILURE);
    }
    // AUTH
    redisReply* replyAuth = redisCommand(conn, "AUTH %s", redisPwd);
    if (replyAuth->type == REDIS_REPLY_ERROR) {
        printf("[REDIS ERR] %s\n", replyAuth->str);
        return quit(EXIT_FAILURE);
    }
    freeReplyObject(replyAuth);
    // SELECT
    redisReply* replySelect = redisCommand(conn, "SELECT %s", redisDB);
    if (replySelect->type == REDIS_REPLY_ERROR) {
        printf("[REDIS ERR] %s\n", replySelect->str);
        return quit(EXIT_FAILURE);
    }
    freeReplyObject(replySelect);
    //
    char *redisKey = (char *) malloc(strlenKey);
    char *redisVal = (char *) malloc(strlenVal);
    redisReply* reply = redisCommand(conn, "SET %s %s" , strlenKey, redisVal);
    free(redisKey);
    free(redisVal);
    if (reply->type == REDIS_REPLY_ERROR) {
        printf("[REDIS ERR] %s\n", reply->str);
    }
    freeReplyObject(reply);
    return 1;
}