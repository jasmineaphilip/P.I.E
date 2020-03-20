//
//  tcpClient.h
//  testingTCP
//
//  Created by Kajal  on 3/1/20.
//  Copyright © 2020 Kajal . All rights reserved.
//

#ifndef tcpClient_h
#define tcpClient_h

#include <stdio.h>
#include <netdb.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <unistd.h>
#include <string.h>
#include <arpa/inet.h>


const char* recvMessage(int sockfd);
float recvOpenFaceResult(int sockfd);
int makeConnection(int portnum);
void sendMessage(const char* buff, int sockfd,int len);

#endif /* tcpClient_h */
