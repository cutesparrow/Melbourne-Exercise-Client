//
//  GraphCapsule.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 22/3/21.
//

import SwiftUI

struct GraphCapsule: View {
    var high:Int
    var low:Int
    var rate:Float

    var body: some View {
        Capsule()
            .fill(Color.white)
            .frame(height: (Float(high-low)*rate)>20 ? CGFloat(Float(high-low)*rate) : 23)
    }
}

struct GraphCapsule_Previews: PreviewProvider {
    static var previews: some View {
        // The graph that uses the capsule tints it by multiplying against its
        // base color of white. Emulate that behavior here in the preview.
        GraphCapsule(high: 63, low: 34,rate: 0.9)
            .colorMultiply(.blue)
    }
}
