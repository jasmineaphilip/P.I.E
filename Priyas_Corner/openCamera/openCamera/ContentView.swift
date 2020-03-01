//
//  ContentView.swift
//  openCamera
//
//  Created by Kajal  on 2/29/20.
//  Copyright © 2020 Kajal . All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var image: Image? = nil
    @State var showCaptureImageView: Bool = false
    
    var body: some View {
      ZStack {
        VStack {
          Button(action: {
            self.showCaptureImageView.toggle()
          }) {
            Text("Take a Photo!").font(.title)
          }
          image?.resizable()
            .frame(width: 250, height: 200)
            
        }.padding(.all,40)
        if (showCaptureImageView) {
          CaptureImageView(isShown: $showCaptureImageView, image: $image)
        }
      }
    }
}
struct CaptureImageView {
  @Binding var isShown: Bool
  @Binding var image: Image?
  
  func makeCoordinator() -> Coordinator {
    return Coordinator(isShown: $isShown, image: $image)
  }
    
}
extension CaptureImageView: UIViewControllerRepresentable {
    func makeUIViewController(context: UIViewControllerRepresentableContext<CaptureImageView>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .camera

        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController,
                                context: UIViewControllerRepresentableContext<CaptureImageView>) {
        
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
