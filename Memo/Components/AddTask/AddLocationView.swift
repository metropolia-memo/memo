//
//  AddLocationView.swift
//  Memo
//
//  Created by Oskari Arponen on 19.4.2022.
//

import SwiftUI
import MapKit
import CoreData
import CoreLocation

// Displays a MapKit map and a TextField for searching locations.
struct AddLocationView: View {
  
    var moc : NSManagedObjectContext
    
    @StateObject var addLocationMapData = AddLocationMapViewModel()
    @State private var locationManager = CLLocationManager()
    
    @Binding var display : Bool
    @Binding var location : TaskLocation?
    @Binding var editingTask : Bool

    var body: some View {
        ZStack {
            
            if display {
                
            AddLocationMapView()
                .environmentObject(addLocationMapData)
                .ignoresSafeArea(.all, edges: .all)
         
                VStack {
                    VStack {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .scaleEffect(1)
                                .opacity(0.5)
                            TextField("Search location..", text: $addLocationMapData.searchText)
                                .background(Color.white)
                            Spacer()
                            if (addLocationMapData.searchText != "") {
                                Button(action: {addLocationMapData.searchText = ""}) {
                                    Image(systemName: "xmark")
                                        .scaleEffect(1)
                                }
                            }
                        }
                        
                        // Displaying a list of search results, if there are any.
                        if (!addLocationMapData.taskPlaces.isEmpty && addLocationMapData.searchText != "") {
                            ScrollView {
                                VStack(spacing: 0) {
                                    ForEach(addLocationMapData.taskPlaces) {taskPlace in
                                        VStack {
                                            Text(taskPlace.place.name ?? "")
                                                .foregroundColor(Color.black)
                                                .bold()
                                            
                                        }
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.vertical, 20)
                                        .contentShape(Rectangle())
                                        .onTapGesture {
                                            addLocationMapData.selectFoundLocation(place: taskPlace)
                                        }
                                      
                                        Divider()
                                    }
                                }
                            }
                        }
    
                      
                        if (addLocationMapData.searchText == "" && addLocationMapData.selectedLocation != nil) {
                            Divider()
                                .padding(.top, 10)
                            HStack {
                           
                                Image(systemName: "pin.fill")
                                    .scaleEffect(1)
                                    .foregroundColor(Color.blue)
                                Text(addLocationMapData.selectedLocation?.place.name ?? "")
                    
                                Spacer()
                                Button(action: {

                                    // Creating a new TaskLocation and closing the AddLocationView window.
                                    location = TaskLocation(context: moc)
                                    location?.longitude = addLocationMapData.selectedLocation?.place.location?.coordinate.longitude ?? 0
                                    location?.latitude = addLocationMapData.selectedLocation?.place.location?.coordinate.latitude ?? 0
                                    location?.name = addLocationMapData.selectedLocation?.place.name ?? "Unknown"
                                    location?.id = UUID()

                                    display = false

                                }) {
                                    Text("Confirm")
                                        .foregroundColor(Color.white)
                                }
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(10)
                                .shadow(radius: 5)

                            }

                        }
                        
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)
    
                    Spacer()
                    
                    VStack {
                        Button(action: addLocationMapData.toggleMapType) {
                            Image(systemName: addLocationMapData.mapType == .standard ? "network" : "map")
                                .font(.title)
                                .padding(10)
                                .background(Color.white)
                                .clipShape(Circle())
                        }
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding()
                }
                .padding()
                .padding(.vertical, editingTask ? 80 : 10)
                .navigationBarTitle("", displayMode: .inline)
                .navigationBarItems(leading: Button(action: {
                    if (!editingTask) {
                        display = false
                    }
                    }) {
                    if (!editingTask) {
                        Image(systemName: "chevron.left")
                         .foregroundColor(Color.blue)
                         .scaleEffect(1)
                    }
                })
                .onChange(of: addLocationMapData.searchText, perform: {value in
                
                    // Searching the map with the given parameters. Applying a delay, preventing overwhelming amounts of queries in case of constant parameter change.
                    let delay = 0.3
                    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                        if value == addLocationMapData.searchText {
                            addLocationMapData.searchLocation()
                        }
                    }
                    
                })
                .onAppear(perform: {
                    
                    // Checking if the user has enabled location.
                    locationManager.delegate = addLocationMapData
                    locationManager.requestWhenInUseAuthorization()
                    
                })
            }
          
        }
  
    }
}
