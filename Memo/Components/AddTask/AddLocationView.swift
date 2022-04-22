//
//  AddLocationView.swift
//  Memo
//
//  Created by Oskari Arponen on 19.4.2022.
//

import SwiftUI
import MapKit
import CoreData

struct SelectedLocation: Identifiable {
    let id = UUID()
    var coordinate: CLLocationCoordinate2D
}

struct AddLocationView: View {
  

    var moc : NSManagedObjectContext
    
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 60.2255, longitude: 24.6575), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    @State private var regionCoordinates = CLLocationCoordinate2D(latitude: 51.5, longitude: -0.12)
    @State private var locationInput = ""
    
    @State private var selectedLocation = [SelectedLocation]()
    
    @State private var locationName = ""
    @State private var locationNotFound = false
    @Binding var display : Bool
    @Binding var location : TaskLocation?
    
    // Searches the map with the given input.
    func searchLocation(input: String) {
        let searchReq = MKLocalSearch.Request()
        searchReq.naturalLanguageQuery = input
        
        let search = MKLocalSearch(request: searchReq)
        
        search.start {response, error in
            guard let response = response else {
                print("Error: \(error?.localizedDescription ?? "Unknown error").")
                    locationName = ""
                    locationNotFound = true
                        return
            }
            
            // Sets the found location to the selectedLocation array.
            print(response.mapItems)
            if let name = response.mapItems[0].name,
               let location = response.mapItems[0].placemark.location {
                
                        print("\(name): \(location.coordinate.latitude),\(location.coordinate.longitude)")
                
                            regionCoordinates = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                
                            let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
                
                            region = MKCoordinateRegion(center: regionCoordinates, span: span)
                            
                            locationName = name
                
                            selectedLocation = [SelectedLocation(coordinate: regionCoordinates)]
                
                    }

                
            
            
        }
    }
    
    
    var body: some View {
        ZStack {
            if display {
                Map(coordinateRegion: $region, annotationItems: selectedLocation) {
                    MapMarker(coordinate: $0.coordinate)
                }
                .ignoresSafeArea()
              
                VStack {
                    VStack {
                        HStack {
                            TextField("Karamalmi, karaportti 2", text: $locationInput)
                                .padding()
                                .background(Color.white)
                            Button(action: {searchLocation(input: locationInput)}) {
                                Image(systemName: "magnifyingglass")
                                    .scaleEffect(2)
                                    .padding()
                                    .shadow(radius: 5)
                            }
                        }
                      
                        if (locationName != "") {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("Found location:")
                                        .font(.title2)
                                    Text(locationName)
                                }
                                Spacer()
                                Button(action: {
                                    
                                    location = TaskLocation(context: moc)
                                    location?.longitude = regionCoordinates.longitude
                                    location?.latitude = regionCoordinates.latitude
                                    location?.name = locationName
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
                }
                .padding()
                .alert("Location not found!", isPresented: $locationNotFound) {
                        Button("OK", role: .cancel) {
                            locationNotFound = false
                        }
                }
            }
          
        }
  
    }
}

struct AddLocationView_Previews: PreviewProvider {
    static var moc = NSManagedObjectContext()
    static var previews: some View {
        AddLocationView(moc: moc, display: .constant(true), location: .constant(TaskLocation()))
    }
}
