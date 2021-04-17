//
//  testView.swift
//  MelbExercise
//
//  Created by gaoyu shi on 16/4/21.
//

import SwiftUI

struct testView: View {
    @State var a = [1,2,3,4]
    @State var select:Int = 0
    var body: some View {
        TabView(selection: $select) {
            ForEach(a, id: \.self) { i in
                Text("\(i)")
                    .tag(i)
            }
        }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        .padding(.vertical,-15)
    }
}

struct testView_Previews: PreviewProvider {
    static var previews: some View {
        testView()
    }
}
