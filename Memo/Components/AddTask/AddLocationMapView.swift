//
//  AddLocationMapView.swift
//  Memo
//
//  Created by Oskari Arponen on 26.4.2022.
//

import SwiftUI
import MapKit
import CoreLocation

// A Custom mapView, used for selecting a location for a Task.
struct AddLocationMapView: UIViewRepresentable {

    @EnvironmentObject var data: AddLocationMapViewModel
    
    func makeCoordinator() -> Coordinator {
        return AddLocationMapView.Coordinator()
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let view = data.mapView
        view.showsUserLocation = true
        view.delegate = context.coordinator
        return view
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {}
    class Coordinator: NSObject, MKMapViewDelegate {}
}


// Stores the data of a MKMapView and handles search queries & location picking.
class AddLocationMapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
   
    @Published var mapView = MKMapView()
    @Published var region : MKCoordinateRegion!
    @Published var mapType : MKMapType = .standard
    @Published var searchText = ""
    @Published var permissionDenied = false
    @Published var taskPlaces : [TaskPlace] = []
    @Published var selectedLocation : TaskPlace?
    
    func selectFoundLocation(place: TaskPlace) {
        
        searchText = ""
        
        // Getting the selected coordinates and creating a new annotation with it.
        guard let coordinate = place.place.location?.coordinate else {return}
        let pointAnnotation = MKPointAnnotation()
        pointAnnotation.coordinate = coordinate
        pointAnnotation.title = place.place.name ?? "Unknown"
        
        // Removing old ones and setting a new annotation to the map.
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotation(pointAnnotation)
        
        // Moving the map to the selected location.
        let cRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        mapView.setRegion(cRegion, animated: true)
        mapView.setVisibleMapRect(mapView.visibleMapRect, animated: true)
        
        selectedLocation = place
    }
    
    // Checks for the authorization status of user location.
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        switch manager.authorizationStatus {
            case .denied:
            permissionDenied.toggle()
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case.authorizedWhenInUse:
            manager.requestLocation()
        default:
            ()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    // Moves the map location to the user's location.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else {return}
        self.region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        self.mapView.setRegion(self.region, animated: true)
        self.mapView.setVisibleMapRect(self.mapView.visibleMapRect, animated: true)
        
    }
    
    
    // Toggles the mapType variable.
    func toggleMapType() {
        if mapType == .standard {
            mapType = .hybrid
            mapView.mapType = mapType
        }
        else {
            mapType = .standard
            mapView.mapType = mapType
        }
    }
    
    // Searches the map with the given search TextField input.
    func searchLocation() {
        
        // Emptying the TaskPlace array before adding fresh results to it.
        taskPlaces.removeAll()
        
        // Creating a local search with the given searchText input.
        let searchReq = MKLocalSearch.Request()
        searchReq.naturalLanguageQuery = searchText
        let search = MKLocalSearch(request: searchReq)
        search.start {(response, _) in
            guard let result = response else {return}
            
            // Mapping the found places into the taskPlaces array.
            self.taskPlaces = result.mapItems.compactMap({ (item) -> TaskPlace? in
                return TaskPlace(place: item.placemark)
            })
            
        }
    }
}

// Placeholder struct used in temporarily storing search results.
struct TaskPlace: Identifiable {
    var id = UUID()
    var place: CLPlacemark
}
