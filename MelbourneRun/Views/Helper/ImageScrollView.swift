//
//  ImageScrollView.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 18/3/21.
//

import SwiftUI



struct ImageScrollView: View {
    let Images: [ScrollImage]
       
       var body: some View {
          
               ScrollView(.horizontal, showsIndicators: false) {
                   HStack {
                       ForEach(Images, id: \.id) { Image in
                           ScrollBoxView(image: Image)
                       }
                   }
                   Spacer()
               }.padding(20)
                   
               
           
       }
}

struct ImageScrollView_Previews: PreviewProvider {
    static var previews: some View {
        ImageScrollView(Images: [ScrollImage(id: 1, image: "gym1"),ScrollImage(id: 2, image: "gym2")])
    }
}
