//
//  FavoriteRouteCard.swift
//  MelbExercise
//
//  Created by gaoyu shi on 26/4/21.
//

import SwiftUI
import SDWebImageSwiftUI
import BottomSheet





struct FavoriteRouteCard: View {
    @Environment(\.managedObjectContext) var context
    @ObservedObject var route:RouteCore
    @State var showDetail:Bool = false
    
    func getColor()->Color{
        if route.type == "Cycling"{
            return AppColor.shared.joggingColor
        } else{
            switch route.risk {
            case "low":
                return AppColor.shared.lowRiskColor
            case "no":
                return AppColor.shared.noRiskColor
            case "mid":
                return AppColor.shared.midRiskColor
            case "high":
                return AppColor.shared.highRiskColor
            default:
                return AppColor.shared.joggingColor
            }
        }
    }
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
            Button(action: {
                self.showDetail.toggle()
            }, label: {
                ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)){
                    getColor()
                        .clipShape(RoundedRectangle(cornerRadius: 15.0))
                        .frame(width: 150,height: 100)
                    VisualEffectView(effect: UIBlurEffect(style: .systemThinMaterial))
                        
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .frame(width: 150,height: 100)
                    VStack(alignment:.leading){
                        Text(route.type ?? "")
                            .foregroundColor(.white)
                            .bold()
                            .lineLimit(1)
                        HStack{
                            Text("\(route.length.description) KM")
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
            
            Button(action: {
                context.performAndWait {
                    withAnimation {
                        context.delete(route)
                        do {
                            try context.save()
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                }
                
                
            }) {
                Image(systemName: "heart.fill")
                    .foregroundColor(AppColor.shared.gymColor)
                    .font(.title)
                
            }.offset(x:100,y:55)
            
        }
        .fullScreenCover(isPresented: $showDetail, content: {
            
            HomePageRouteDetailView(route: route,showDetail:$showDetail)
                .background(Color(.systemBackground).clipShape(RoundedRectangle(cornerRadius: 25.0)))
                .clearModalBackground()
                .offset(y: 90)
            

//                            .clearModalBackground()
        })
//        .bottomSheet(isPresented: $showDetail, height: 400, content: {
//            HomePageRouteDetailView(route: route)
//        })
        .frame(width: 150,height: 100)
    }
}


struct ClearBackgroundView: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = UIColor(Color(.black).opacity(0.4))
        }
        return view
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}

struct ClearBackgroundViewModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .background(ClearBackgroundView())
    }
}

extension View {
    func clearModalBackground()->some View {
        self.modifier(ClearBackgroundViewModifier())
    }
}
