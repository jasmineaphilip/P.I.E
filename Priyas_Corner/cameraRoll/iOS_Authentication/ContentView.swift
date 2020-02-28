//
//  ContentView.swift
//  iOS_Authentication
//
//  Created by Kajal  on 2/25/20.
//  Copyright © 2020 Kajal . All rights reserved.
//

import SwiftUI



struct ContentView: View {
//    @State private var showDetails = false
//    @State var camera = false
//    @State var totalClicked: Int = 0
    @State var isClicked = false
    @State private var image: Image? = nil
    @State private var showImagePicker: Bool = false
    
    var body: some View {
        
        
        VStack{
         
            
            image?.resizable().scaledToFit()
            Text("click below").font(.title)
            Spacer()
            Button(action: {self.showImagePicker.toggle()})
            {
                Text("click me hoe")
            }.sheet(isPresented:
                self.$showImagePicker) {
                PhotoCaptureView(showImagePicker: self.$showImagePicker, image: self.$image)
            }
            
        }.padding(.all,40)
        
        
    }
    
  

    
    
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


