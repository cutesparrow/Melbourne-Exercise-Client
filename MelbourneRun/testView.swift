//
//  testView.swift
//  MelbExercise
//
//  Created by gaoyu shi on 10/5/21.
//

import SwiftUI

struct testView: View {
    var body: some View {
        VStack(alignment: .leading){
            ZStack{
                VisualEffectView(effect: UIBlurEffect(style: .dark))
                ScrollView(.horizontal,showsIndicators: false){
                    
                    HStack{
                        Image("yarra-trail")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 300, height: 200, alignment: .center)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
//                        ForEach(self.result){ route in
//                            FavoriteRouteCard(route:route)
//                                .padding(.leading)
//                        }
//                        AddFavoriteCard(color: Color(.systemBackground))
//                            .padding(.horizontal)
//                            .onTapGesture {
//                                withAnimation{bottomBarSelected = 2}
//                            }
                    }
                    
                }
       }
        }.frame(height: 230)
    }
}

struct testView_Previews: PreviewProvider {
    static var previews: some View {
        testView()
    }
}
