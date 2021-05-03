//
//  LoopingImageView.swift
//  MelbExercise
//
//  Created by gaoyu shi on 3/5/21.
//

import SwiftUI
import Looping
import LoopingWebP



struct LoopingImageView: View {
    let image: LoopImage = try! LoopImage(url: URL(string: NetworkManager.shared.urlBasePath + "1.1.png")!)
    var body: some View {
        Loop(image, placeholder: {Color.blue})
            .loopMode(.infinite)
                           .playBackSpeedRate(4)
                           .resizable()
                           .scaledToFill()
                           .frame(width: 200, height: 200)
                           .clipped(antialiased: true)
    }
}

struct LoopingImageView_Previews: PreviewProvider {
    static var previews: some View {
        LoopingImageView()
    }
}
