//
//  ScrollBoxView.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 18/3/21.
//

import SwiftUI

struct ScrollBoxView: View {
    var image:ScrollImage
    var body: some View {
        Image(image.image)
            .resizable(capInsets: EdgeInsets(), resizingMode: .stretch)
            .scaledToFill()
            .frame(width: UIScreen.main.bounds.width/1.5, height: UIScreen.main.bounds.height/2)
            .clipped()
            .cornerRadius(14)
            .shadow(radius: 4)
    }
}

struct ScrollBoxView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollBoxView(image: ScrollImage(id: 1, image: "gym1"))
    }
}
