//
//  GymListCardTabView.swift
//  MelbExercise
//
//  Created by gaoyu shi on 3/5/21.
//

import SwiftUI
import CoreData
import Combine

struct GymListCardTabView: View {
//    @EnvironmentObject var userData:UserData
//    @State var selectedGymIndex:Int
    @Binding var selectedGymUid:Int
    let detector: CurrentValueSubject<CGFloat, Never>
    let publisher: AnyPublisher<CGFloat, Never>
    @EnvironmentObject var userData:UserData
//    @Binding var gotTap:Bool
    @Binding var search:String
//    @Binding var isSearching:String
    var fetchRequest: FetchRequest<GymCore>
//    @Binding var selectedGymClass:String
    var gyms:FetchedResults<GymCore> {
        fetchRequest.wrappedValue
    }
//    let content:(T) -> Content
    
//    private func findIndexOfGym(gym:T) -> Int?{
//        var index:Int = 0
//        for i in gyms{
//            if (gym as! GymCore).uid == (i as! GymCore).uid{
//                return index
//            }
//            index += 1
//        }
//        return nil
//    }
    
    init(classType:String,search:Binding<String>,selectedGymUid:Binding<Int>) {
//        selectedGymClass = classType
//        selectedGymIndex = 0
        self._selectedGymUid = selectedGymUid
//        self._selectedGymIndex = State(initialValue: 0)
//        self._gotTap = gotTap
//        self._isSearching = isSearching
        self._search = search
        if classType == "No membership"{
            if search.wrappedValue == ""
            {fetchRequest = FetchRequest<GymCore>(entity: GymCore.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \GymCore.distance, ascending: true)])}
            else if search.wrappedValue.caseInsensitiveCompare("star") == .orderedSame{
                fetchRequest = FetchRequest<GymCore>(entity: GymCore.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \GymCore.distance, ascending: true)], predicate: NSPredicate(format: "star == %i", true))
            }
            else{
                fetchRequest = FetchRequest<GymCore>(entity: GymCore.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \GymCore.distance, ascending: true)], predicate: NSPredicate(format: "name CONTAINS[c] %@ OR address CONTAINS[c] %@ OR classType CONTAINS[c] %@", search.wrappedValue,search.wrappedValue,search.wrappedValue))
            }
        }
        else {
            if search.wrappedValue == ""{
                fetchRequest = FetchRequest<GymCore>(entity: GymCore.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \GymCore.distance, ascending: true)], predicate: NSPredicate(format: "classType == %@", classType))
            }
            else if search.wrappedValue.caseInsensitiveCompare("star") == .orderedSame{
                fetchRequest = FetchRequest<GymCore>(entity: GymCore.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \GymCore.distance, ascending: true)], predicate: NSPredicate(format: "classType == %@ AND star == %i", classType, true))
            }
            else{fetchRequest = FetchRequest<GymCore>(entity: GymCore.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \GymCore.distance, ascending: true)], predicate: NSPredicate(format: "classType == %@ AND (name CONTAINS[c] %@ OR address CONTAINS[c] %@ OR classType CONTAINS[c] %@)", classType, search.wrappedValue,search.wrappedValue,search.wrappedValue))}
            
        }
        
//        self.content = content
        let detector = CurrentValueSubject<CGFloat, Never>(0)
        self.publisher = detector
                    .debounce(for: .seconds(0.2), scheduler: DispatchQueue.main)
                    .dropFirst()
                    .eraseToAnyPublisher()
        self.detector = detector
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
                LazyHStack(alignment:.bottom){
                ForEach(self.gyms,id:\.self){gym in
    //                        if gym.classType == userData.hasMemberShip || userData.hasMemberShip == "No membership"{
                    GymCard(gym:gym,selectedGymUid:$selectedGymUid)
                        .id(Int(gym.uid))
                }
            }.padding(.horizontal,18)
                GeometryReader { proxy in
                                        let offset = proxy.frame(in: .named("scroll")).minX//may need change
                                        Color.clear.preference(key: ViewOffsetKey.self, value: offset)
                                    }
            }
            }
//            .onChange(of:gotTap,perform:{ num in
////                withAnimation(.easeInOut(duration:1)){
//                DispatchQueue.main.async{
//                    withAnimation(.easeInOut(duration:1)){value.scrollTo(selectedGymUid,anchor:.center)}
//                }
////                }
//            })
            .onChange(of:selectedGymUid,perform:{ _ in
//                withAnimation(.easeInOut(duration:1)){
                DispatchQueue.main.async{
                    withAnimation(.easeInOut(duration:1)){value.scrollTo(selectedGymUid,anchor:.center)}
                }
//                }
            })
         
            
        }
        .coordinateSpace(name: "scroll")
        .onPreferenceChange(ViewOffsetKey.self) { value in
            detector.send(value)
//            self.selectedGymIndex = Int(-(value-348.5/2)/348.5)
        }
        .onReceive(publisher) { value in
            DispatchQueue.main.async{ self.selectedGymUid = Int(gyms[Int(-(value-348.5/2)/348.5)].uid)}
        }
        
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/3-10, alignment: .center)
//        .onChange(of: selectedGymIndex, perform: { value in
//            DispatchQueue.main.async{ self.selectedGymUid = Int((gyms[value] as! GymCore).uid)}
////            print(selectedGymUid.description)
//        })
        .background(Color(.clear))
        .onChange(of: userData.hasMemberShip, perform: { value in
            print("change membership")
            DispatchQueue.main.async{ self.selectedGymUid = Int(gyms[0].uid)} //may need change
//            print(selectedGymUid.description)
        })
        .onChange(of: search, perform:{value in
            if gyms.isEmpty{
            }
            else{
                DispatchQueue.main.async{
                    self.selectedGymUid = Int(gyms[0].uid)
                }
            }
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
