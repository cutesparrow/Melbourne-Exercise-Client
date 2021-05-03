//
//  GymListCardTabView.swift
//  MelbExercise
//
//  Created by gaoyu shi on 3/5/21.
//

import SwiftUI
import CoreData

struct GymListCardTabView<T: NSManagedObject,Content: View>: View {
//    @EnvironmentObject var userData:UserData
    @State var selectedGymIndex:Int
    @Binding var selectedGymUid:Int
    @EnvironmentObject var userData:UserData
    @Binding var gotTap:Bool
    var fetchRequest: FetchRequest<T>
//    @Binding var selectedGymClass:String
    var gyms:FetchedResults<T> {
        fetchRequest.wrappedValue
    }
    let content:(T) -> Content
    
    private func findIndexOfGym(gym:T) -> Int?{
        var index:Int = 0
        for i in gyms{
            if (gym as! GymCore).uid == (i as! GymCore).uid{
                return index
            }
            index += 1
        }
        return nil
    }
    init(classType:String,search:String,selectedGymUid:Binding<Int>, gotTap:Binding<Bool>,@ViewBuilder content:@escaping (T) -> Content) {
//        selectedGymClass = classType
//        selectedGymIndex = 0
        self._selectedGymUid = selectedGymUid
        self._selectedGymIndex = State(initialValue: 0)
        self._gotTap = gotTap
        if classType == "No membership"{
            if search == ""
            {fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \GymCore.distance, ascending: true)])}
            else{
                fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \GymCore.distance, ascending: true)], predicate: NSPredicate(format: "name CONTAINS %@", search))
            }
        }
        else {
            if search == ""{
                fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \GymCore.distance, ascending: true)], predicate: NSPredicate(format: "classType == %@", classType))
            }
            else{fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \GymCore.distance, ascending: true)], predicate: NSPredicate(format: "classType == %@ AND name CONTAINS %@", classType, search))}
            
        }
        self.content = content
    }
//    private func findIndexOfGym(gym:GymCore) -> Int?{
//        var index:Int = 0
//        for i in result{
//            if gym.uid == i.uid{
//                return index
//            }
//            index += 1
//        }
//        return nil
//    }
    var body: some View {
        
        ScrollViewReader{ value in
            ScrollView(.horizontal, showsIndicators: false)
        {
            ZStack{
                LazyHStack{
                ForEach(self.fetchRequest.wrappedValue,id:\.self){gym in
    //                        if gym.classType == userData.hasMemberShip || userData.hasMemberShip == "No membership"{
                    self.content(gym)
                        .id(Int((gym as! GymCore).uid))
                }
            }.padding(.horizontal,18)
                GeometryReader { proxy in
                                        let offset = proxy.frame(in: .named("scroll")).minX
                                        Color.clear.preference(key: ViewOffsetKey.self, value: offset)
                                    }
            }
            }.onChange(of:gotTap,perform:{ num in
//                withAnimation(.easeInOut(duration:1)){
                DispatchQueue.main.async{value.scrollTo(selectedGymUid,anchor:.center)}
//                }
            })
            
        }
        .coordinateSpace(name: "scroll")
        .onPreferenceChange(ViewOffsetKey.self) { value in
            self.selectedGymIndex = Int(-(value-348.5/2)/348.5)
        }
        
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2.38, alignment: .center)
        .onChange(of: selectedGymIndex, perform: { value in
            DispatchQueue.main.async{ self.selectedGymUid = Int((gyms[value] as! GymCore).uid)}
//            print(selectedGymUid.description)
        })
        .onChange(of: userData.hasMemberShip, perform: { value in
            print("change membership")
            DispatchQueue.main.async{ self.selectedGymUid = Int((gyms[selectedGymIndex] as! GymCore).uid)}
//            print(selectedGymUid.description)
        })
//        ScrollView{
//            HStack{
//                TabView{
//                    ForEach(self.fetchRequest.wrappedValue,id:\.self){
//                    gym in
//                    self.content(gym)
//                }
//                }.tabViewStyle(PageTabViewStyle())
//            }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2.38, alignment: .center)
//        }
    }
}
struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}
