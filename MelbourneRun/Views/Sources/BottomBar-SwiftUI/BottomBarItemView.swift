//
//  BottomBarItemView.swift
//  BottomBar
//
//  Created by Bezhan Odinaev on 7/2/19.
//  Copyright © 2019 Bezhan Odinaev. All rights reserved.
//

import SwiftUI

public struct BottomBarItemView: View {
    @Binding var selected : Int
    public let index: Int
    public let item: BottomBarItem
    
    public var body: some View {
        VStack {
            VStack{
                item.icon
                .imageScale(.large)
                .foregroundColor(isSelected ? item.color : .primary)
//                if !isSelected{
//                    Text(item.title)
//                        .font(.caption2)
//                        .foregroundColor(.primary)
//                }
                
            }
            
                Text(item.title)
                    .foregroundColor(isSelected ? item.color : .primary)
                    .font(.caption)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            
        }

        .padding()
//        .background(
//            Capsule()
//                .fill(isSelected ? item.color.opacity(0.2) : Color.clear)
//        )
    }
    
    var isSelected : Bool{
        selected == index
    }
    
}
