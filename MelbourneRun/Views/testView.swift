//
//  testView.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 27/3/21.
//

import SwiftUI

struct PageView:View {
    var body: some View{
        TabView{
            ForEach(0..<20){
                i in
                ZStack{
                    Color(.label)
                    
                }.clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
            }.padding(.all,10)
        }.frame(width: UIScreen.main.bounds.width, height: 200)
        .tabViewStyle(PageTabViewStyle())
    }
}

struct testView: View {
    var body: some View {
        ScrollView{
            LazyHStack{
                PageView()
            }
        }
    }
}

struct testView_Previews: PreviewProvider {
    static var previews: some View {
        testView()
    }
}
