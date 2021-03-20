//
//  BottomContentView.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 19/3/21.
//

import SwiftUI

struct BottomContentView: View {
    var body: some View {
        VStack{
            HStack{
                Text("Distance")
                    .font(.title)
                    .bold()
                    .frame(width: UIScreen.main.bounds.width/2, height: 100, alignment: .leading)
                Spacer()
                Text("x min")
                    .font(.body)
                    .foregroundColor(Color(.black).opacity(0.7))
                    .frame(width: UIScreen.main.bounds.width/5, height: 100, alignment: .trailing)
            }
            .padding(.leading,20)
            .padding(.trailing,20)
            .frame(width: UIScreen.main.bounds.width, height: 60, alignment: .center)
            HStack{
                
            }
        }
    }
}

struct BottomContentView_Previews: PreviewProvider {
    static var previews: some View {
        BottomContentView()
    }
}
