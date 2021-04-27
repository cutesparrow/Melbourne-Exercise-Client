//
//  testView.swift
//  MelbExercise
//
//  Created by gaoyu shi on 16/4/21.
//

import SwiftUI

struct testView: View {
    @State var a:Bool = false

    var body: some View {
        Button(action: {self.a.toggle()}) {
            Text("a")
        }
//        .present(isPresented: $a,type:.floater(verticalPadding: 10), closeOnTap: false,closeOnTapOutside: false) {
//            ZStack{
//                RoundedRectangle(cornerRadius: 25.0)
//                    .fill(Color(.blue))
//                    .frame(width: 100, height: 100, alignment: .center)
//                Button(action: {}, label: {
//                    Text("Button")
//                })
//            }
//        }
    }
}

struct testView_Previews: PreviewProvider {
    static var previews: some View {
        testView()
    }
}
