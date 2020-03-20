//
//  tcpClient.c
//  testingTCP
//
//  Created by Kajal  on 3/1/20.
//  Copyright © 2020 Kajal . All rights reserved.
//

#include "tcpClient.h"


#define SA struct sockaddr


int sockfd, connfd, PORT;

const char* recvMessage(int sockfd){
    //TODO this theoretically will always be an int so no worries
    char buff[100];
    read(sockfd,buff,100);
    printf("received message: %s\n", buff);
    char* message = buff;
    return message;
}

float recvOpenFaceResult(int sockfd){
    char buff[100];
    read(sockfd,buff,100);
    char* message = buff;
    printf("received openface result: %s\n", message);
    float result = strtof(message,NULL);
    return result;
}

void sendMessage(const char* buff, int sockfd,int len)
{
    //printf("buffer is = %s\n", buff);
    write(sockfd,buff,len);
//    int n;
//    for (;;) {
//        bzero(buff, sizeof(buff));
//        printf("Enter the string : ");
//        n = 0;
//        while ((buff[n++] = getchar()) != '\n')
//            ;
//        write(sockfd, buff, sizeof(buff));
//        bzero(buff, sizeof(buff));
//        read(sockfd, buff, sizeof(buff));
//        printf("From Server : %s", buff);
//        if ((strncmp(buff, "exit", 4)) == 0) {
//            printf("Client Exit...\n");
//            break;
//        }
//    }
}
  
int makeConnection(int portnum){
    struct sockaddr_in servaddr;
    
      // socket create and varification
      sockfd = socket(AF_INET, SOCK_STREAM, 0);
      if (sockfd == -1) {
          printf("socket creation failed...\n");
          exit(0);
      }
      else
          printf("Socket successfully created..\n");
      bzero(&servaddr, sizeof(servaddr));
    PORT = portnum;
    printf("port number = %d\n", portnum);
      // assign IP, PORT
    struct hostent *host = gethostbyname("192.168.86.36");
    
    servaddr.sin_family = AF_INET;
    servaddr.sin_addr = *(struct in_addr*)* host -> h_addr_list;
    servaddr.sin_port = htons(PORT);
    
      // connect the client socket to server socket
      if (connect(sockfd, (SA*)&servaddr, sizeof(servaddr)) != 0) {
          printf("connection with the server failed...\n");
          return -1;
      }
      else
          printf("connected to the server..\n");
        
 
    return sockfd;

    
}

void closeConnection(){
    close(sockfd);
}

//int main()
//{
//    int sockfd, connfd;
//    struct sockaddr_in servaddr, cli;
//
//    // socket create and varification
//    sockfd = socket(AF_INET, SOCK_STREAM, 0);
//    if (sockfd == -1) {
//        printf("socket creation failed...\n");
//        exit(0);
//    }
//    else
//        printf("Socket successfully created..\n");
//    bzero(&servaddr, sizeof(servaddr));
//
//    // assign IP, PORT
//    servaddr.sin_family = AF_INET;
//    servaddr.sin_addr.s_addr = inet_addr("127.0.0.1");
//    servaddr.sin_port = htons(PORT);
//
//    // connect the client socket to server socket
//    if (connect(sockfd, (SA*)&servaddr, sizeof(servaddr)) != 0) {
//        printf("connection with the server failed...\n");
//        exit(0);
//    }
//    else
//        printf("connected to the server..\n");
//
//    // function for chat
//    func(sockfd);
//
//    // close the socket
//    close(sockfd);
//}
