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

//Creates a map and an annotations for taskScreen
struct MapView: View {
    
    @Binding var task: Task?
    @StateObject private var viewModel = MapViewModel()
    
    @State private var region: MKCoordinateRegion
    
    public var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    public var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    init(task: Binding<Task?>) {
        self._task = task
        
        let taskUnwrapped = task.wrappedValue
    
        if (taskUnwrapped?.taskLocation != nil) {
            self.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: taskUnwrapped?.taskLocation?.latitude ?? 0.0, longitude: taskUnwrapped?.taskLocation?.longitude ?? 0.0), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        } else {
            self.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 60.266190, longitude: 24.847280), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        }
        
    }
    
    
    var body: some View {
        
        //Holds a location which can be pinned in the map
        let taskPlace = [
            Place(name: task?.name ?? "Unknown", coordinate: CLLocationCoordinate2D(latitude: task?.taskLocation?.latitude ?? 0, longitude: task?.taskLocation?.longitude ?? 0))
        ]
        
        HStack(spacing: 0) {

            Map(coordinateRegion: $region, showsUserLocation: true, annotationItems: taskPlace, annotationContent: { place in MapAnnotation(coordinate: place.coordinate) {
                CustomAnnotation()
                }
            })
            .frame(width: screenWidth, height: screenHeight)
            .ignoresSafeArea()
            .accentColor(Color(.systemRed))
            .onAppear {
                viewModel.checkIfLocationServices()
            }
            
        }
    }
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


