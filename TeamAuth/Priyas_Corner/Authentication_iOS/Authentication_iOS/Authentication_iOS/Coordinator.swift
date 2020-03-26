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

    let port : Int32 = 1234
    let sockfd = makeConnection(port)
    if (sockfd > 0){
        print("great:)")
        let length : String = "\(encoded.count)"
        print(encoded.count)
        sendMessage(length, sockfd, 8) //sends size of image
        sendMessage(encoded, sockfd, Int32(encoded.count)) //send encoded image
        print("done sending image!")
        //check if image matches
        recvMessage(sockfd)
    }
    
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
