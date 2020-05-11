//
//  ContentView.swift
//  SwiftUI Drag Colors
//
//  Created by Isaac Raval on 5/10/20.
//  Copyright © 2020 Isaac Raval. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var permanentColoring: [Color] = [.clear,.clear,.clear,.clear,.clear,.clear,.clear,.clear,.clear,.clear]
    @State var lastColorDragged:colorsDragged = .none
    var body: some View {
        HStack {
            ColorSource(color: .purple, color2: .orange, permanentColoring: self.$permanentColoring, lastColorDragged: self.lastColorDragged)
            Spacer()
            ColorSource(color: .blue, color2: .pink, permanentColoring: self.$permanentColoring, lastColorDragged: self.lastColorDragged)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct DestinationDataKey: PreferenceKey {
    typealias Value = [DestinationData]

    static var defaultValue: [DestinationData] = []

    static func reduce(value: inout [DestinationData], nextValue: () -> [DestinationData]) {
        value.append(contentsOf: nextValue())
    }
}

struct DestinationData: Equatable {
    let destination: Int
    let frame: CGRect
}

struct DestinationDataSetter: View {
    let destination: Int

    var body: some View {
        GeometryReader { geometry in
            Rectangle()
                .fill(Color.clear)
                .preference(key: DestinationDataKey.self,
                            value: [DestinationData(destination: self.destination, frame: geometry.frame(in: .global))])
        }
    }
}

struct DestinationView: View {
    @Binding var active: Int
    let label: String
    let id: Int
    let color: Color
    let color2: Color
    @Binding var permanentColoring:[Color]
    @Binding var lastColorDragged:colorsDragged

    var body: some View {
        Text(label).padding(10).background( ((self.active == id) ) ? (self.lastColorDragged == .first ? color : (self.lastColorDragged == .second ? color2 : .yellow)) : self.permanentColoring[self.id])
                .background(DestinationDataSetter(destination: id))
            .onTapGesture {
                if(self.lastColorDragged == .first) {
                    print("First color dragged: \(self.color) and not \(self.color2)")
                    self.permanentColoring[self.id] = self.color
                    print(self.permanentColoring[self.id])
                }
                else if(self.lastColorDragged == .second){
                    print("Second color dragged: \(self.color2) and not \(self.color)")
                    self.permanentColoring[self.id] = self.color2
                    print(self.permanentColoring[self.id])
                }
        }
    }
}

enum colorsDragged {
    case first, second, none
}

struct ColorSource: View {
    @State var active = 0
    @State var destinations: [Int: CGRect] = [:]
    @State var color:Color
    @State var color2:Color
    @State var draggingFirstColor:Bool = false
    @State var draggingSecondColor:Bool = false
    @Binding var permanentColoring:[Color]
    @State var lastColorDragged:colorsDragged

    var body: some View {
        VStack {
            
            Text("Drag Color From Here").padding().background(color)
                .gesture(DragGesture(minimumDistance: 0.1, coordinateSpace: .global)
                    .onChanged { value in
                        self.draggingFirstColor = true
                        self.lastColorDragged = .first
                        self.active = 0
                        for (id, frame) in self.destinations {
                            if frame.contains(value.location) {
                                self.active = id
                            }
                        }
                    }
                    .onEnded { value in
                        // do something on drop
//                        self.active = 0
//                        self.draggingFirstColor = false
                        
                    }
            )
            
            Text("Drag Color From Here").padding().background(color2)
                .gesture(DragGesture(minimumDistance: 0.1, coordinateSpace: .global)
                    .onChanged { value in
                        self.draggingSecondColor = true
                        self.lastColorDragged = .second
                        self.active = 0
                        for (id, frame) in self.destinations {
                            if frame.contains(value.location) {
                                self.active = id
                            }
                        }
                    }
                    .onEnded { value in
                        // do something on drop
//                        self.active = 0
//                         self.draggingSecondColor = false
                    }
            )
            
            Divider()
            DestinationView(active: $active, label: "Drag A Color Here", id: 1, color: self.color, color2: self.color2, permanentColoring: self.$permanentColoring, lastColorDragged: self.$lastColorDragged)
            DestinationView(active: $active, label: "Drag A Color Here", id: 2, color: self.color, color2: self.color2, permanentColoring: self.$permanentColoring, lastColorDragged: self.$lastColorDragged)
            DestinationView(active: $active, label: "Drag A Color Here", id: 3, color: self.color, color2: self.color2, permanentColoring: self.$permanentColoring, lastColorDragged: self.$lastColorDragged)
            DestinationView(active: $active, label: "Drag A Color Here", id: 4, color: self.color, color2: self.color2, permanentColoring: self.$permanentColoring, lastColorDragged: self.$lastColorDragged)
        }.onPreferenceChange(DestinationDataKey.self) { preferences in
            for p in preferences {
                self.destinations[p.destination] = p.frame
            }
        }
    }
}
