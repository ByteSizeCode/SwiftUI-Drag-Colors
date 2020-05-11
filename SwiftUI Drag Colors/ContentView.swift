//
//  ContentView.swift
//  SwiftUI Drag Colors
//
//  Created by Isaac Raval on 5/10/20.
//  Copyright © 2020 Isaac Raval. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            ColorSource(colors: [.purple,.orange, .yellow, .green, .gray, .clear], lastColorDragged: .none)
            Spacer()
            ColorSource(colors: [.blue,.pink, .gray, .purple, .white, .black], lastColorDragged: .none)
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

enum colorsDragged {
    case first, second, third, fourth, fifth, sixth, none
}

struct DestinationView: View {
    @Binding var active: Int
    let label: String
    let id: Int
    let colors: [Color]
    @Binding var permanentColoring:[Color]
    @Binding var lastColorDragged:colorsDragged

    var body: some View {
        Text(label).padding(10).background( ((self.active == id) ) ? (self.lastColorDragged == .first ? colors[0] : (self.lastColorDragged == .second ? colors[1] : (self.lastColorDragged == .third ? colors[2] : (self.lastColorDragged == .fourth ? colors[3] : (self.lastColorDragged == .fifth ? colors[4] : (self.lastColorDragged == .sixth ? colors[5] : .clear)))))) : self.permanentColoring[self.id])
                .background(DestinationDataSetter(destination: id))
            .onTapGesture {
                if(self.lastColorDragged == .first) {
//                    print("First color dragged: \(self.colors[0]) and not \(self.colors[1])")
                    self.permanentColoring[self.id] = self.colors[0]
                    print(self.permanentColoring[self.id])
                }
                else if(self.lastColorDragged == .second){
                    self.permanentColoring[self.id] = self.colors[1]
                    print(self.permanentColoring[self.id])
                }
                else if(self.lastColorDragged == .third){
                    self.permanentColoring[self.id] = self.colors[2]
                    print(self.permanentColoring[self.id])
                }
                else if(self.lastColorDragged == .fourth){
                    self.permanentColoring[self.id] = self.colors[3]
                    print(self.permanentColoring[self.id])
                }
                else if(self.lastColorDragged == .fifth){
                    self.permanentColoring[self.id] = self.colors[4]
                    print(self.permanentColoring[self.id])
                }
                else if(self.lastColorDragged == .sixth){
                    self.permanentColoring[self.id] = self.colors[5]
                    print(self.permanentColoring[self.id])
                }
        }
    }
}

struct ColorSource: View {
    @State var active = 0
    @State var destinations: [Int: CGRect] = [:]
    @State var colors:[Color]
    @State var draggingFirstColor:Bool = false
    @State var draggingSecondColor:Bool = false
    @State var lastColorDragged:colorsDragged
    @State var permanentColoring: [Color] = [.clear,.clear,.clear,.clear,.clear,.clear,.clear,.clear,.clear,.clear]

    var body: some View {
        VStack {
            
            HStack(spacing: 5) {
                VStack(spacing: 5) {
                    Text("Drag Color From Here").padding().background(self.colors[0])
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
                    
                    Text("Drag Color From Here").padding().background(colors[1])
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
                }
                VStack(spacing: 5) {
                    Text("Drag Color From Here").padding().background(self.colors[2])
                        .gesture(DragGesture(minimumDistance: 0.1, coordinateSpace: .global)
                            .onChanged { value in
                                self.draggingFirstColor = true
                                self.lastColorDragged = .third
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
                    
                    Text("Drag Color From Here").padding().background(colors[3])
                        .gesture(DragGesture(minimumDistance: 0.1, coordinateSpace: .global)
                            .onChanged { value in
                                self.draggingSecondColor = true
                                self.lastColorDragged = .fourth
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
                }
                VStack(spacing: 5) {
                    Text("Drag Color From Here").padding().background(self.colors[4])
                        .gesture(DragGesture(minimumDistance: 0.1, coordinateSpace: .global)
                            .onChanged { value in
                                self.draggingFirstColor = true
                                self.lastColorDragged = .fifth
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
                    
                    Text("Delete Color Drag This").padding().background(colors[5])
                     .border(Color.gray)
                        .gesture(DragGesture(minimumDistance: 0.1, coordinateSpace: .global)
                            .onChanged { value in
                                self.draggingSecondColor = true
                                self.lastColorDragged = .sixth
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
                }
            }
            
            Divider()
            DestinationView(active: $active, label: "Drag A Color Here", id: 1, colors: self.colors, permanentColoring: self.$permanentColoring, lastColorDragged: self.$lastColorDragged)
            DestinationView(active: $active, label: "Drag A Color Here", id: 2, colors: self.colors, permanentColoring: self.$permanentColoring, lastColorDragged: self.$lastColorDragged)

            DestinationView(active: $active, label: "Drag A Color Here", id: 3, colors: self.colors, permanentColoring: self.$permanentColoring, lastColorDragged: self.$lastColorDragged)

            DestinationView(active: $active, label: "Drag A Color Here", id: 4, colors: self.colors, permanentColoring: self.$permanentColoring, lastColorDragged: self.$lastColorDragged)

        }.onPreferenceChange(DestinationDataKey.self) { preferences in
            for p in preferences {
                self.destinations[p.destination] = p.frame
            }
        }
    }
}
