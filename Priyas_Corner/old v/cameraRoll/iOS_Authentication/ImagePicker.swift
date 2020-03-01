//
//  imagePicker.swift
//  iOS_Authentication
//
//  Created by Kajal  on 2/26/20.
//  Copyright © 2020 Kajal . All rights reserved.
//
//  credit to https://www.youtube.com/watch?time_continue=21&v=W60nnRFUGaI&feature=emb_logo
//  https://github.com/azamsharp/AzamSharp-Weekly/blob/master/CapturingPhotoSwiftUI/CapturingPhotoSwiftUI/ImagePicker.swift

import Foundation
import SwiftUI

class ImagePickerCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
        
    @Binding var isShown: Bool
    @Binding var image: Image?
    
    init(isShown: Binding<Bool>, image: Binding<Image?>){
        _isShown = isShown
        _image = image
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //select photo from photo library or camera
        var uiImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage

        image = Image(uiImage : uiImage)
        isShown = false
    
        print("resizing image")
        uiImage = self.resizeImage(image: uiImage, targetSize: CGSize(width: 1700, height: 1700))
        
        
        print("here")
        
        let data = uiImage.jpegData(compressionQuality: 0.0) //the snapshot image converted into byte data
        let encoded = data!.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
        // byte image data is encoded to a base64String
        
        let client = TCPClient(address: "assembly.cs.rutgers.edu", port: Int32(6666))
        var _: Result = client.connect(timeout: 10)
        let length : String = "\(encoded.count)"
        print(encoded.count)
        client.send(string: length)
        client.send(string: encoded)
        
        //client.send(string: encoded)
        print("done")
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
    
    //option to cancel
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        isShown = false
    }
    
    

    
    
}

struct ImagePicker: UIViewControllerRepresentable{
    @Binding var isShown: Bool
    @Binding var image: Image?
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        
        
    }
    
    func makeCoordinator() -> ImagePickerCoordinator {
        return ImagePickerCoordinator(isShown: $isShown, image: $image)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    
}
