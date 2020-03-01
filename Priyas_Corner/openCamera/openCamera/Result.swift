//
//  Result.swift
//  openCamera
//
//  Created by Kajal  on 2/29/20.
//  Copyright © 2020 Kajal . All rights reserved.
//

import Foundation
public enum Result {
 case success
 case failure(Error)
 
 public var isSuccess: Bool {
   switch self {
   case .success:
     return true
   case .failure:
     return false
   }
 }
   
 public var isFailure: Bool {
   return !isSuccess
 }

 public var error: Error? {
   switch self {
   case .success:
     return nil
   case .failure(let error):
     return error
   }
 }
}
