//
//  MapView.swift
//  Memo
//
//  Created by Jani Salo on 20.4.2022.
//
import MapKit
import SwiftUI
import Alamofire

//Places are used for map pins
struct Place: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}



struct MapView: View {
    
    let task: Task
    @StateObject private var viewModel = MapViewModel()
    
    
    public var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    public var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    
    
    var body: some View {
        
        let latitude = task.taskLocation?.latitude ?? 0
        let longitude = task.taskLocation?.longitude ?? 0
        
        //Holds a location which can be pinned in the map
        let taskPlace = [
            Place(name: task.name!, coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
        ]
        
        
        HStack(spacing: 0) {

            
        Map(coordinateRegion: $viewModel.region, showsUserLocation: true, annotationItems: taskPlace) { place in MapPin(coordinate: place.coordinate)}
            .frame(width: screenWidth, height: screenHeight)
            .ignoresSafeArea()
            .accentColor(Color(.systemRed))
            .onAppear {
                viewModel.checkIfLocationServices()
            }
        }
    }
    
//struct MapView_Previews: PreviewProvider {
   // static var previews: some View {
   //     MapView()
   // }
//}
}


final class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapV: MKMapView!
    
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 60.266190, longitude: 24.847280), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    
    var locationManager: CLLocationManager?
    
    //Checks if location services are enabled
    func checkIfLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager!.delegate = self
        } else {
            print("Make an alert letting user know that location services have to turned on")
        }
    }
    
    //Checks if user have given authorization to app to use the location
    private func checkLocationAuth() {
        guard let locationManager = locationManager else {
            return
        }
        
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("something")
        case .denied:
            print("something")
            
        case .authorizedAlways, .authorizedWhenInUse:
            region = MKCoordinateRegion(center: locationManager.location!.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        @unknown default:
            break
        }
    }
    //Function is ran everytime when authorization settings have been changed. And will run checklocationAuth function to check if application is allowed to use user location.
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuth()
    }
    
    }


