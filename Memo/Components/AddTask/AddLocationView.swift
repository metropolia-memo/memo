//
//  AddLocationView.swift
//  Memo
//
//  Created by Oskari Arponen on 19.4.2022.
//

import SwiftUI
import MapKit

struct SelectedLocation: Identifiable {
    let id = UUID()
    var coordinate: CLLocationCoordinate2D
}

struct AddLocationView: View {
    @Environment(\.managedObjectContext) var moc
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.5, longitude: -0.12), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    @State private var regionCoordinates = CLLocationCoordinate2D(latitude: 51.5, longitude: -0.12)
    @State private var locationInput = ""
    
    @State private var selectedLocation = [SelectedLocation]()
    
    @State private var locationName = ""
    
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
                        return
            }
            
            // Prints the found location and moves the map to it.
            for item in response.mapItems {
                if let name = item.name,
                            let location = item.placemark.location {
                    
                            print("\(name): \(location.coordinate.latitude),\(location.coordinate.longitude)")
                    
                                regionCoordinates = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                    
                                let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
                    
                                region = MKCoordinateRegion(center: regionCoordinates, span: span)
                                
                                locationName = name
                    
                                selectedLocation = [SelectedLocation(coordinate: regionCoordinates)]
                    
                        }
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
                    TextField("Set text", text: $locationInput)
                        .padding()
                        .background(Color.white)
                    Spacer()
                    HStack {
                        Button(action: {searchLocation(input: locationInput)}) {
                            Image(systemName: "plus")
                                .scaleEffect(2)
                                .foregroundColor(Color.white)
                        }
                        .padding(40)
                        .background(Color.blue)
                        .clipShape(Circle())
                        
                        Spacer()
                        
                        Button(action: {
                            
                            location = TaskLocation(context: moc)
                            location?.longitude = regionCoordinates.longitude
                            location?.latitude = regionCoordinates.latitude
                            location?.name = locationName
                            location?.id = UUID()

                            display = false
                            
                        }) {
                            Image(systemName: "hand.thumbsup.fill")
                                .scaleEffect(2)
                                .foregroundColor(Color.white)
                        }
                        .padding(40)
                        .background(Color.blue)
                        .clipShape(Circle())
                        
                    }
                    .padding()
                }
                .padding()
            }
        }
  
    }
}

struct AddLocationView_Previews: PreviewProvider {
    static var previews: some View {
        AddLocationView(display: .constant(true), location: .constant(TaskLocation()))
    }
}
