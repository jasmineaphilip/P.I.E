//
//  Coordinator.swift
//  openCamera
//
//  Created by Kajal  on 2/29/20.
//  Copyright © 2020 Kajal . All rights reserved.
//

import Foundation
import SwiftUI

class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
  @Binding var isCoordinatorShown: Bool
  @Binding var image: Image?
    
  init(isShown: Binding<Bool>, image: Binding<Image?>) {
    _isCoordinatorShown = isShown
    _image = image
  }
  func imagePickerController(_ picker: UIImagePickerController,
                didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
     guard let unwrapImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
     image = Image(uiImage: unwrapImage)
     isCoordinatorShown = false
    var uiImage = unwrapImage
    print("resizing image")
    uiImage = self.resizeImage(image: uiImage, targetSize: CGSize(width: 1700, height: 1700))
    
    
    print("here")
    
    let data = uiImage.jpegData(compressionQuality: 0.0) //the snapshot image converted into byte data
    let encoded = data!.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
    // byte image data is encoded to a base64String
    
    let client = TCPClient(address: "assembly.cs.rutgers.edu", port: Int32(5555))
    var _: Result = client.connect(timeout: 10)
    let length : String = "\(encoded.count)"
    print(encoded.count)
    client.send(string: length)
    client.send(string: encoded)
    
    //client.send(string: encoded)
    print("done")
    
    //check if image matches
//    let value : Int32? = client.readSize()!
//    print("recvd value")
//    print(value!)
    
    let sockfd : Int32 = client.fd!
    let bytesRead : Int32 = readSize(sockfd)
    print("bytes")
    print(bytesRead)
    
  }

    
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size

        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height

        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }

        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
    
    
    
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
     isCoordinatorShown = false
  }
}
