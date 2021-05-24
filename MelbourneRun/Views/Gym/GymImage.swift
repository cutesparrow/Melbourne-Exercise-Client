//
//  GymImage.swift
//  MelbExercise
//
//  Created by gaoyu shi on 19/5/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct GymImage: View,Equatable {
    static func == (lhs: GymImage, rhs: GymImage) -> Bool {
        return lhs.image.uid == lhs.image.uid
    }
    var image:ImageCore
    var body: some View {
        WebImage(url: URL(string: NetworkManager.shared.urlBasePath + image.name + ".jpg"))
            .placeholder{
                Color.gray
            }
            .resizable()
            .scaledToFill()
            .frame(width:230,height:110)
            .clipped()
    }
}


