//
//  FavoritePopularRouteCard.swift
//  MelbExercise
//
//  Created by gaoyu shi on 27/4/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct FavoritePopularRouteCard: View {
    @Environment(\.managedObjectContext) var context
    @ObservedObject var popularRoute:PopularRouteCore
    @State var showDetail:Bool = false
    
    var body: some View {
        HStack{ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
//            NavigationLink(destination: GymRecordView(fetchedGym:gym))
//            {
            Button(action: {self.showDetail.toggle()}, label: {
                ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)){WebImage(url: URL(string: NetworkManager.shared.urlBasePath + popularRoute.background))
                            .resizable()
                            .clipShape(RoundedRectangle(cornerRadius: 15.0))
                            .frame(width: 150,height: 100)
            VisualEffectView(effect: UIBlurEffect(style: .light))

                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .frame(width: 150,height: 100)
            VStack(alignment:.leading){
                Text(popularRoute.name)
                    .foregroundColor(.white)
                    .bold()
                    .lineLimit(1)
                HStack{
                    Text("\(popularRoute.distance.description) KM")
                        .font(.caption)
                        .foregroundColor(.white)
                        .bold()
                        
                        .lineLimit(1)
                    Spacer(minLength: 0)
                    
                }.padding(.top,20)
            }
            .padding(.horizontal,10)
            .padding(.vertical,10)
                }
            })
//            }
            Button(action: {
                context.performAndWait {
                    withAnimation {
                        popularRoute.star.toggle()
                        try? context.save()
                    }
                }
                if popularRoute.star{
                    print("liked")
                } else{
                    print("disliked")
                }
                
            }) {
                Image(systemName: popularRoute.star ? "heart.fill" : "heart")
                    .foregroundColor(AppColor.shared.gymColor)
                    .font(.title)
                    
            }.offset(x:100,y:55)
            
        }}
        .sheet(isPresented: $showDetail, content: {
            HomePagePopularJoggingRouteDetailVIew(popularRoute: popularRoute)
               
//                            .clearModalBackground()
        })
        .frame(width: 150,height: 100)
    }
}

