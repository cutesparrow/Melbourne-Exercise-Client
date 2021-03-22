//
//  CircleImageView.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 15/3/21.
//

import SwiftUI
import SDWebImageSwiftUI




struct CircleImageView: View {
    var imageName:String
    var size: CGFloat
    var body: some View {
        WebImage(url: URL(string: NetworkManager.shared.urlBasePath + imageName + ".jpg"))
            .placeholder{
                Color.gray
            }
            .resizable()
            .scaledToFill()
            .aspectRatio(contentMode: .fill)
            .frame(width: size, height: size, alignment: .center)
            .clipShape(Circle())
    }
}

struct CircleImageView_Previews: PreviewProvider {
    static var previews: some View {
        CircleImageView(imageName: "IMG_3080",size: 100.0)
    }
}
