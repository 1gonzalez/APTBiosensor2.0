//
//  MainView.swift
//  BioSensor
//
//  Created by Rivera Torres, Patria I. on 2/15/23.
//

import SwiftUI
import CoreMotion

struct MainMenu: View {
    @Binding var tabSelection: Int
    @State var showingPopup = false
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var tilts: FetchedResults<Tilt>
    var motion = CMMotionManager()
    let conVal = 180/Double.pi
    @State var pelvicTilt:Double = 0.0
    var body: some View {
        ZStack{
            Color(red: 0.50, green: 0.82, blue: 0.96).edgesIgnoringSafeArea(.all)
            VStack {
                //                Spacer()
                //                Text("APT BioSensor")
                //                    .font(.largeTitle)
                //                    .fontWeight(.heavy)
                //                    .foregroundColor(Color.orange)
                //                Spacer()
                
                Button(action: {
                    print("Pressed!")
                    Measure()
                    let tilt = Tilt(context: moc)
                    tilt.pitch = pelvicTilt
                    tilt.dateTime = Date.now
                    
                    do{
                        try moc.save()
                    }
                    catch{
                        print("error")
                    }
                }){
                    StrokeText(text: "Tap to Measure", width: 1, color: Color.black)
                        .foregroundColor(Color(red: 0.98, green: 0.69, blue: 0.27))
                        .font(.system(size: 60, weight: Font.Weight.bold))
                        .frame(width: 350, height: 350)
                        .background(Color(red: 0.82, green: 0.88, blue: 0.92))
                        .clipShape(Circle())
                        .shadow(radius: 20)
                    /*
                    Text("Tap to Measure")
                        .font(.system(size: 60, weight: Font.Weight.bold))
                        .frame(width: 350, height: 350)
                        .foregroundColor(Color(red: 0.98, green: 0.69, blue: 0.27))
                        .background(Color(red: 0.82, green: 0.88, blue: 0.92))
                        .clipShape(Circle())
                        .shadow(radius: 20)
                     */
                }
                .padding()
                .frame(maxHeight: .infinity)
                Spacer()
                
                Button("Quick Start Guide") {
                    showingPopup = true
                }
                
                .lineLimit(1)
                .fixedSize()
                .font(.system(size: 14))
                .padding()
                .foregroundColor(.white)
                .background(Color.accentColor)
                .cornerRadius(10)
                .padding()
                .onTapGesture {
                    self.tabSelection=4
                }
                .popover(isPresented: $showingPopup, arrowEdge: .bottom) {
                    QuickStartGuideView()
                    //Text("test")
                    //.frame(width: 100, height: 100)
                }
                Spacer()
            }
        }
        
    }
    
    func Measure() {
        if self.motion.isDeviceMotionAvailable {
            self.motion.deviceMotionUpdateInterval = 0.0000001
            self.motion.startDeviceMotionUpdates(
                using: .xMagneticNorthZVertical,
                to: .main) {(data, error) in
                    if let trueData = data{
                        self.pelvicTilt = 85 - abs(trueData.attitude.pitch * self.conVal)
                        //Double(Int(10*(90-abs(trueData.attitude.yaw*self.conVal))))/10
                    }
                }
        }
    }
}

struct StrokeText: View {
    let text: String
    let width: CGFloat
    let color: Color
    
    var body: some View {
        ZStack{
            ZStack{
                Text(text).offset(x: width, y: width)
                Text(text).offset(x: -width, y: -width)
                Text(text).offset(x: -width, y:  width)
                Text(text).offset(x:  width, y: -width)
            }
            .foregroundColor(color)
            Text(text)
        }
    }
}
