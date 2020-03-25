//
//  ContentView.swift
//  openCamera
//
//  Created by Kajal  on 3/11/20.
//  Copyright © 2020 Kajal . All rights reserved.
//

import SwiftUI

enum ActivateAlert {
    case success,fail
}

struct ContentView: View {
    
    @State var image: Image? = nil
    @State var showCaptureImageView: Bool = false
    @State var isMatch: Bool = false
    @State var showAlert: Bool = false
    @State var alert : ActivateAlert = .fail
  
    
    var body: some View {
        ZStack {
            VStack {
                Button(action: {
                    self.showCaptureImageView.toggle()
                }) {
                    Text("Take a Photo!").font(.title)
                }
                image?.resizable()
                    .frame(width: 350, height: 480)
                
            }
            
            if (showCaptureImageView) {
                CaptureImageView(isShown: $showCaptureImageView, image: $image, isMatch: $isMatch, showAlert: $showAlert)
            }
            
            
            
        }.alert(isPresented: $showAlert){
            print("is match currently...")
            print(isMatch)
            if (isMatch){
                isMatch = false
                showAlert = false
                return Alert(title: Text("Success!"), message: Text("You've been verified"), dismissButton: .default(Text("Thanks!")))
            }
            else{
                showAlert = false
                return Alert(title: Text("Failed!"), message: Text("Please Try Again"), dismissButton: .default(Text("Okay")))
            }
        }
    }

    func reset(){
        print("resetting...")
        isMatch = false
        showAlert = false
    }
}



//struct getBool{
//    @Binding var isMatch: Bool
//    func negate() -> Binding<Bool>{
//        isMatch.toggle()
//        return $isMatch
//    }
//}

struct CaptureImageView {
    @Binding var isShown: Bool
    @Binding var image: Image?
    @Binding var isMatch: Bool
    @Binding var showAlert: Bool
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(isShown: $isShown, image: $image, isMatch: $isMatch, showAlert: $showAlert)
        
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
