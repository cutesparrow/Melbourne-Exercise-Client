//
//  CircleImagePlusView.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 18/3/21.
//

import SwiftUI

struct CircleImagePlusView: View {
    var name:String
    var body: some View {
        Image(name)
            .resizable(capInsets: EdgeInsets(), resizingMode: .stretch)
            .scaledToFill()
            .frame(width: UIScreen.main.bounds.width/3, height: UIScreen.main.bounds.width/3, alignment: .center)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 4))
            .shadow(radius: 7)
        
    }
}

struct CircleImagePlusView_Previews: PreviewProvider {
    static var previews: some View {
        CircleImagePlusView(name: "gym1")
    }
}
