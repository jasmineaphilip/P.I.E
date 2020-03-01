//
//  attempt.c
//  openCamera
//
//  Created by Kajal  on 3/1/20.
//  Copyright © 2020 Kajal . All rights reserved.
//

#include "attempt.h"
#include <unistd.h>
#include <stdlib.h>
#include <string.h>

int readSize(int socketfd){
    char buff[100]; //the int will be stored in buffer
    if (read(socketfd, buff, 100) >= 0) return 500;
    return -100;

}
