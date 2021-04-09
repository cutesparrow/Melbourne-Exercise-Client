//
//  PathShowView.swift
//  MelbExercise
//
//  Created by gaoyu shi on 9/4/21.
//

import SwiftUI

struct PathShowView: View {
    var path:[Coordinate]
    var height:Int
    var body: some View {
        MapView(coordinates: path)
            .frame(width: UIScreen.main.bounds.width/1.3, height: UIScreen.main.bounds.height/CGFloat(height), alignment: .center)
            .cornerRadius(10)
            .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.systemGray4), lineWidth: 2))
            .shadow(radius: 13)
        //            .shadow(radius: 10)
        //            .clipShape(RoundedRectangle(cornerRadius: 25.0))
    }
}

struct PathShowView_Previews: PreviewProvider {
    static var previews: some View {
        PathShowView(path: [Coordinate(latitude: -37.81228028830977, longitude: 144.96229225616813),
                            Coordinate(latitude: -37.816196112093316, longitude: 144.96404105636753),Coordinate(latitude: -37.81470439418989, longitude: 144.96899777840505)], height: 2)
    }
}
