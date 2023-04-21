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
                        .font(.system(size: 60, weight: Font.Weight.bold))
                        .frame(width: 350, height: 350)
                        .foregroundColor(Color(red: 0.98, green: 0.69, blue: 0.27))
                        .background(Color(red: 0.93, green: 0.93, blue: 0.93))
                        .clipShape(Circle())
                        .shadow(radius: 5)
                }
                .padding()
                .frame(maxHeight: .infinity)
                .shadow(radius: 20)
                Spacer()
                
                Button("Quick Start Guide") {
                    showingPopup = true
                }
                .lineLimit(1)
                .fixedSize()
                .font(.system(size: 18))
                .padding()
                .foregroundColor(.white)
                .background(Color(red: 0.98, green: 0.69, blue: 0.27))
                .cornerRadius(10)
                .padding()
                .shadow(radius: 2)
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
