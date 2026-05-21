//
//  LocationDetailView.swift
//  IOSDevuk26
//

import SwiftUI
import MapKit

struct LocationDetailView: View {
    @Environment(ViewModel.self) private var viewModel
    let locationID: String

    private var location: Location { viewModel.locationFrom(locationID: locationID) }

    private var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Map(initialPosition: .region(
                    MKCoordinateRegion(
                        center: coordinate,
                        latitudinalMeters: 500,
                        longitudinalMeters: 500
                    )
                )) {
                    Marker(location.name, coordinate: coordinate)
                }
                .frame(height: 400)
                .clipShape(.rect(cornerRadius: 12))
                .accessibilityRepresentation {
                    Button("Open in Maps", systemImage: "map") {
                            let item = MKMapItem(placemark: MKPlacemark(coordinate: coordinate))
                            item.name = location.name
                            item.openInMaps()
                        }
                        .accessibilityHint("Opens this location in Apple Maps")
                }
                .padding(.horizontal)

                Text(location.placeDescription)
                    .foregroundStyle(.secondary)
                    .padding()
            }
        }
        .navigationTitle(location.name)
        .navigationBarTitleDisplayMode(.large)
    }
}
