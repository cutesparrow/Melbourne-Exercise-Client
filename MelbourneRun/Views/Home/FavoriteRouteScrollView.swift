//
//  FavoriteRouteScrollView.swift
//  MelbExercise
//
//  Created by gaoyu shi on 26/4/21.
//

import SwiftUI

struct FavoriteRouteScrollView: View {
    @Binding var bottomBarSelected:Int
    @Environment(\.managedObjectContext) var context
    @FetchRequest(entity: RouteCore.entity(), sortDescriptors: []) var result: FetchedResults<RouteCore>
    var body: some View {
        VStack(alignment:.leading){
//            Text("Favorite Routes")
//                .font(.title3)
//                .bold()
//                .foregroundColor(Color(.label))
//                .padding(.leading)
//                .padding(.bottom,-5)
        
            ScrollView(.horizontal,showsIndicators: false){
                
                HStack{
                    ForEach(self.result){ route in
                        FavoriteRouteCard(route:route)
                            .padding(.leading)
                    }
                    AddFavoriteCard(color: Color(.systemBackground))
                        .padding(.horizontal)
                        .onTapGesture {
                            withAnimation{bottomBarSelected = 2}
                        }
                }
                
            }
            
        }
    }
}


