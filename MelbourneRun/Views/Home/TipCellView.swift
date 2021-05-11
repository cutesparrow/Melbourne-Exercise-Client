//
//  TipCellView.swift
//  MelbExercise
//
//  Created by gaoyu shi on 10/5/21.
//

import SwiftUI

struct TipCellView: View {
    var hight:Int = 120
    var content:String = "The Run-Walk Method is a great way for new runners to get started and for experienced runners to improve their race times."
    var body: some View {
        HStack{
            Text(content)
            Spacer(minLength: 0)
        }
        .padding(10)
            .frame(width: UIScreen.main.bounds.width-20, height: CGFloat(hight), alignment: .center)
            .background(Color(.systemBackground).shadow(color: Color.black.opacity(0.12), radius: 5, x: 0, y: 4))
//            .background(Color.blue)
            .cornerRadius(15)
    }
}

struct TipCellView_Previews: PreviewProvider {
    static var previews: some View {
        TipCellView()
    }
}
