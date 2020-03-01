//
//  Socket.swift
//  openCameraTests
//
//  Created by Kajal  on 2/29/20.
//  Copyright © 2020 Kajal . All rights reserved.
//

import Foundation

open class Socket {
  
    public let address: String
    internal(set) public var port: Int32
    internal(set) public var fd: Int32?
  
    public init(address: String, port: Int32) {
        self.address = address
        self.port = port
    }
  
}

public enum SocketError: Error {
    case queryFailed
    case connectionClosed
    case connectionTimeout
    case unknownError
}
