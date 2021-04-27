//
//  FavoriteScrollView.swift
//  MelbExercise
//
//  Created by gaoyu shi on 26/4/21.
//

import SwiftUI

struct FavoriteGymScrollView: View {
    @Binding var bottomBarSelected:Int
    @Environment(\.managedObjectContext) var context
    @FetchRequest(entity: GymCore.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \GymCore.distance, ascending: true)],predicate: NSPredicate(format: "star == %i", true)) var result: FetchedResults<GymCore>
    var body: some View {
        
        VStack(alignment:.leading){
//            Text("Favorite Gyms")
//                .font(.title3)
//                .bold()
//                .foregroundColor(Color(.label))
//                .padding(.leading)
//                .padding(.bottom,-5)
        
            ScrollView(.horizontal,showsIndicators: false){
                
                HStack{
                    ForEach(self.result){ gym in
                        FavoriteCard(gym:gym)
                            .padding(.leading)
                    }
                    AddFavoriteCard(color: Color(.systemBackground))
                        .padding(.horizontal)
                        .onTapGesture {
                            withAnimation{bottomBarSelected = 1}
                        }
                }
                
            }
            
        }
    }
}


