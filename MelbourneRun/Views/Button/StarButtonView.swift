//
//  StarButtonView.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 18/3/21.
//
import SwiftUI

struct StarButtonView: View {
    var color:Color
    @Binding var isStar:Bool
    var body: some View {
        Image(systemName: "star")
            .padding()
            .background(isStar ? color:.white)
            .cornerRadius(40)
            .foregroundColor(isStar ? .white:color) //changed
            .padding(3)
            .overlay(
                RoundedRectangle(cornerRadius: 40)
                    .stroke(color, lineWidth: 3)
            )
        }
    }


struct StarButtonView_Previews: PreviewProvider {
    static var previews: some View {
        StarButtonView(color: Color.blue,isStar: .constant(true))
    }
}
