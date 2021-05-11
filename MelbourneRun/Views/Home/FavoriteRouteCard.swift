//
//  FavoriteRouteCard.swift
//  MelbExercise
//
//  Created by gaoyu shi on 26/4/21.
//

import SwiftUI
import SDWebImageSwiftUI
import BottomSheet

struct RouteFullSreenOptionView: View {
    @ObservedObject var route:RouteCore
    @Binding var showDetail:Bool
    @Binding var showRenameAlert:Bool
    var body: some View {
        if showRenameAlert{
            RenameRouteAlert(route: route,showDetail:$showDetail)
                .onDisappear{
                    showRenameAlert.toggle()
                }
                .clearModalBackground()
        } else {
            HomePageRouteDetailView(route: route,showDetail:$showDetail)
                .background(Color(.systemBackground).clipShape(RoundedRectangle(cornerRadius: 25.0)))
                .clearModalBackground()
                .offset(y: 90)
            }
    }
}
struct RenameRouteAlert: View {
    @ObservedObject var route:RouteCore
    @Environment(\.managedObjectContext) var context
    @State var newName:String = ""
    @Binding var showDetail:Bool
    func rename() -> Void{
        if !newName.isEmpty{
            context.performAndWait {
            withAnimation {
                route.showName = newName
                try? context.save()
            }
        }
        }
    }
    var body: some View {
        ZStack{
            VisualEffectView(effect: UIBlurEffect(style: .systemMaterial))
                .cornerRadius(20.0)
                .shadow(radius: 6)
            VStack{
                Text("Rename")
                    .font(.title2)
                
                TextField("New name ...", text: $newName)
                    .padding(7)
                    .padding(.horizontal, 25)
                    .background(Color(.systemGray5))
                    .cornerRadius(8)
                    .overlay(
                        HStack {
                            Image(systemName: "pencil.circle")
                                .foregroundColor(.gray)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 8)
                        
                        }
                    )
                    .frame(width:UIScreen.main.bounds.width/2)
                    .padding()
                HStack{
                    Button(action: {
                        showDetail.toggle()
                    }, label: {
                        Text("Cancel")
                            .frame(width: 70)
                            .padding(10)
                            .background(RoundedRectangle(cornerRadius: 15).fill(Color.gray.opacity(0.2)))
                            
                    })
                    Spacer(minLength: 0)
                        .frame(width:30)
                    Button(action: {
                        rename()
                        showDetail.toggle()
                    }, label: {
                        Text("OK")
                            .frame(width: 70)
                            .padding(10)
                            .background(RoundedRectangle(cornerRadius: 15).fill(Color.gray.opacity(0.2)))
                    })
                }
            }
        }.frame(width: UIScreen.main.bounds.width/1.4, height: 200, alignment: .center)
    }
}



struct FavoriteRouteCard: View {
    @Environment(\.managedObjectContext) var context
    @ObservedObject var route:RouteCore
    @EnvironmentObject var userData:UserData
    @State var showDetail:Bool = false
    @State var showRenameAlert:Bool = false
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
            
                ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)){
                    getColor()
                        .clipShape(RoundedRectangle(cornerRadius: 15.0))
                        .frame(width: 150,height: 100)
                    VisualEffectView(effect: UIBlurEffect(style: .systemThinMaterial))
                        
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .frame(width: 150,height: 100)
                    VStack(alignment:.leading){
                        Text(route.showName.isEmpty ? route.type : route.showName)
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
                            
                        }.padding(.top,10)
                        HStack{
                            Text(route.addedTime != nil ? route.addedTime! : Date(),style: .date)
                                .font(.caption)
                                .foregroundColor(.white)
                                .bold()
                                
                                .lineLimit(1)
                            Spacer(minLength: 0)
                            
                        }
                    }
                    .padding(.horizontal,10)
                    .padding(.vertical,10)
                }.onTapGesture {
                    print(route.showName)
    //                customAlertManager.show()
                    showDetail.toggle()
                }
                .onLongPressGesture {
                    DispatchQueue.main.async {
                        self.showRenameAlert = true
                        if showRenameAlert == true{
                            showDetail.toggle()
                        }
                    }
                }
           
            
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
            RouteFullSreenOptionView(route: route, showDetail: $showDetail, showRenameAlert: $showRenameAlert)
                .environmentObject(userData)
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
