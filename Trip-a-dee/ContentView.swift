//
//  ContentView.swift
//  Trip-a-dee
//
//  Created by Zach Pregl on 6/3/2024.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    @Binding var offset: CGFloat

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView(frame: .zero)
        mapView.isUserInteractionEnabled = false // Disable user interaction

        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        let newCenter = CLLocationCoordinate2D(latitude: 0, longitude: -179.9 + Double(offset))
        uiView.setCenter(newCenter, animated: true)
        let region = MKCoordinateRegion(center: newCenter, latitudinalMeters: 10000000, longitudinalMeters: 10000000)
        uiView.setRegion(region, animated: true)
    }
}

struct ContentView: View {
    @State private var offset: CGFloat = 0.0 // Variable to control map scrolling
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isSignupButtonClicked = false
    @State private var isLoginButtonClicked = false

    var body: some View {
        ZStack {
            MapView(offset: $offset)
                .edgesIgnoringSafeArea(.all)
                .blur(radius: 15)

            VStack (spacing:20){
                if !isSignupButtonClicked {
                    VStack {
                        Spacer()
                        Button(action: {
                            withAnimation {
                                isSignupButtonClicked = true
                            }
                        }) {
                            Text("Sign Up")
                        }
                        
                        .frame(minWidth: 0, maxWidth: UIScreen.main.bounds.width * 0.75) // Set the frame to allow button to take the maximum available width
                        .padding()
                        
                        .foregroundColor(.white)
                        .background(
                            LinearGradient(colors: [.black.opacity(0.25), .blue.opacity(0.5)], startPoint: .top, endPoint: .bottom))
                        .cornerRadius(14)
                        .opacity(isSignupButtonClicked ? 0 : 1) // Initially fully visible, then fades out when isButtonClicked is true
                        .animation(.smooth(duration: 1), value: 10)
                    }
                    
                    VStack {
                        Button(action: {
                            withAnimation {
                                isSignupButtonClicked = true
                            }
                        }) {
                            Text("Login")
                        }
                        
                        .frame(minWidth: 0, maxWidth: UIScreen.main.bounds.width * 0.75) // Set the frame to allow button to take the maximum available width
                        .padding()
                        .foregroundColor(.white)
                        .background(
                            LinearGradient(colors: [.black.opacity(0.25), .blue.opacity(0.5)], startPoint: .top, endPoint: .bottom))
                        .cornerRadius(14)
                        .opacity(isSignupButtonClicked ? 0 : 1) // Initially fully visible, then fades out when isButtonClicked is true
                        .animation(.smooth(duration: 1), value: 10)// Smooth animation
                    }
                }

                if isSignupButtonClicked {
                    VStack(spacing: 20) { // Set a fixed spacing between the elements
                        TextField("Username", text: $username)
                            .padding()
                            .frame(height: 50)
                            .frame(minWidth: 0, maxWidth: UIScreen.main.bounds.width * 0.75)
                            .background(.ultraThinMaterial)
                            .overlay(
                                LinearGradient(colors: [.black.opacity(0.05), .clear], startPoint: .top, endPoint: .bottom))
                            .cornerRadius(14)
                            .opacity(isSignupButtonClicked ? 1 : 0) // Initially hidden, then fades in when isButtonClicked is true
                            .animation(.easeInOut(duration: 300), value: 10) // Smooth animation

                        SecureField("Password", text: $password)
                            .padding()
                            .frame(height: 50)
                            .frame(minWidth: 0, maxWidth: UIScreen.main.bounds.width * 0.75)
                            .background(.ultraThinMaterial)
                            .overlay(
                                LinearGradient(colors: [.black.opacity(0.05), .clear], startPoint: .top, endPoint: .bottom))
                            .cornerRadius(14)
                            .opacity(isSignupButtonClicked ? 1 : 0) // Initially hidden, then fades in when isButtonClicked is true
                            .animation(.easeInOut(duration: 300), value: 10) // Smooth animation

                        Button(action: {
                            print("Username: \(username), Password: \(password)")
                        }) {
                            Text("Login")
                                .padding()
                                .frame(minWidth: 0, maxWidth: UIScreen.main.bounds.width * 0.40)
                                .foregroundColor(.white)
                                .background(
                                    LinearGradient(colors: [.black.opacity(0.25), .blue.opacity(0.5)], startPoint: .top, endPoint: .bottom))
                                .cornerRadius(14)
                        }
                        .padding()
                        .foregroundColor(Color(hue: 1.0, saturation: 0.256, brightness: 0.191, opacity: 0.28))
                        .opacity(isSignupButtonClicked ? 1 : 0) // Initially hidden, then fades in when isButtonClicked is true
                        .animation(.easeInOut(duration: 300), value: 10) // Smooth animation
                    }
                    .padding()
                    .cornerRadius(14)
                    .padding()
                }
            }
        }
        .onAppear {
            if (offset <= 179.9){
                Timer.scheduledTimer(withTimeInterval: 0.22, repeats: true) { timer in
                    offset += 0.2
                }}else{
                    offset = 0.2
                }
        }
        .foregroundStyle(.thinMaterial)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

