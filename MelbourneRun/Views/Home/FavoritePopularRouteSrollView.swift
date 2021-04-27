//
//  FavoritePopularRouteSrollView.swift
//  MelbExercise
//
//  Created by gaoyu shi on 27/4/21.
//

import SwiftUI

struct FavoritePopularRouteSrollView: View {
    @Binding var bottomBarSelected:Int
    @Environment(\.managedObjectContext) var context
    @FetchRequest(entity: PopularRouteCore.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \PopularRouteCore.uid, ascending: true)],predicate: NSPredicate(format: "star == %i", true)) var result: FetchedResults<PopularRouteCore>
    
    var body: some View {
        VStack(alignment:.leading){
//
        
            ScrollView(.horizontal,showsIndicators: false){
                
                HStack{
                    ForEach(self.result){ popularRoute in
                        FavoritePopularRouteCard(popularRoute: popularRoute)
                            .padding(.leading)
                    }
                    AddFavoriteCard(color: Color(.systemBackground))
                        .padding(.horizontal)
                        .onTapGesture {
                            withAnimation{bottomBarSelected = 3}
                        }
                }
                
            }
            
        }
    }
}

