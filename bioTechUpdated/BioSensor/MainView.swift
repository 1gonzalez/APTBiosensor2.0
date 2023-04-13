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
    @State var pelvicRoll:Double = 0.0
    
    var body: some View {
        ZStack{
            Color(red: 0.50, green: 0.82, blue: 0.96).edgesIgnoringSafeArea(.all)
            VStack {
                Button(action: {
                    print("Pressed!")
                    Measure()
                    let tilt = Tilt(context: moc)
                    tilt.pitch = pelvicTilt
                    tilt.roll = pelvicRoll
                    tilt.dateTime = Date.now
                    
                    do{
                        try moc.save()
                    }
                    catch{
                        print("error")
                    }
                }){
                    Text("Tap to Measure")
                        .foregroundColor(Color(red: 0.98, green: 0.69, blue: 0.27))
                        .font(.system(size: 60, weight: Font.Weight.bold))
                        .frame(width: 350, height: 350)
                        .background(Color(red: 0.82, green: 0.88, blue: 0.92))
                        .clipShape(Circle())
                        .shadow(radius: 20)
                }
                .padding()
                .frame(maxHeight: .infinity)
                Spacer()
                
                Button(action: {showingPopup = true}, label: {Text("Quick Start Guide")})
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
                        self.pelvicRoll = 85 - abs(trueData.attitude.roll * self.conVal)
                        //Double(Int(10*(90-abs(trueData.attitude.yaw*self.conVal))))/10
                    }
                }
        }
    }
}
