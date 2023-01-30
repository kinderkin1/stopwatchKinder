//
//  New.swift
//  stopwatchKinder
//
//  Created by Kin Der on 25.01.2023.
//

import SwiftUI

struct LapClass: Identifiable {
    var id = UUID()
    let lap: Double
    init(_ lap: Double) {
  
        self.lap = lap
    }
}

struct New: View {
    
   @ObservedObject var manager = ManagerClass()
    @State private var lapTimings: [LapClass] = []
    
    
    var body: some View {
        VStack{
            
            Text(String(format: "%.2f", manager.secondElapsed))
                .font(.largeTitle)
                .bold()
            
            
            switch manager.mode {
            case .stopped :
                withAnimation {
                    Button {
                        manager.start()
                    } label: {
                        Image(systemName: "play.fill")
                            .foregroundColor(.white)
                            .font(.title)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(100)
                    }
                
                }
            case .running :
                HStack{
                    
                    withAnimation {
                        Button {
                            manager.stop()
                            lapTimings = []
                        } label: {
                            Image(systemName: "stop.fill")
                                .foregroundColor(.white)
                                .font(.title)
                                .padding()
                                .background(Color.red)
                                .cornerRadius(100)
                        }
                    }
                    withAnimation {
                        Button {
                            let newLap = LapClass(manager.secondElapsed)
                            lapTimings.append(newLap)
                        } label: {
                            Image(systemName: "stopwatch.fill")
                                .foregroundColor(.white)
                                .font(.title)
                                .padding()
                                .background(Color.green)
                                .cornerRadius(100)
                        }
                    }
                    withAnimation  {
                        Button {
                            manager.pause()
                        } label: {
                            Image(systemName: "pause.fill")
                                .foregroundColor(.white)
                                .font(.title)
                                .padding()
                                .background(Color.orange)
                                .cornerRadius(100)
                        }}
                    
                    
                    Button {
                        SharePreview("dd")
                    } label: {
                        Image(systemName: "square.and.arrow.up")
                            .foregroundColor(.white)
                            .font(.title)
                            .padding()
                            .background(Color.orange)
                            .cornerRadius(100)
                    }
                    
                    
                }
            case .pause:
                HStack{
                    withAnimation {
                        Button {
                            manager.start()
                        } label: {
                            Image(systemName: "play.fill")
                                .foregroundColor(.white)
                                .font(.title)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(100)
                        }}
                    withAnimation  {
                        Button {
                            manager.stop()
                            lapTimings = []
                        } label: {
                            Image(systemName: "stop.fill")
                                .foregroundColor(.white)
                                .font(.title)
                                .padding()
                                .background(Color.red)
                                .cornerRadius(100)
                        }}
                   
                }
               
                }
            List(lapTimings) {lap in
                Text("\(String(format: "%.2f", lap.lap)) s")
            }
                    
                }
            
      
        
    }
}

enum mode {
    case running
    case stopped
    case pause
}



class ManagerClass: ObservableObject {
    @Published var secondElapsed = 0.0
    @Published var mode: mode = .stopped
    
    var timer = Timer()
    func start() {
        mode = .running
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { timer in
            self.secondElapsed += 0.1
        })
    }
    func stop() {
        timer.invalidate()
        secondElapsed = 0
        mode = .stopped
    }
    func pause()  {
        timer.invalidate()
        mode = .pause
    }
}
    func ShareId(Info: String){
        let infoUI = Info
        let av = UIActivityViewController (activityItems: [infoUI], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(av,animated: true, completion: nil)
        if UIDevice.current.userInterfaceIdiom == .pad{
            av.popoverPresentationController?.sourceView=UIApplication.shared.windows.first
            av.popoverPresentationController?.sourceRect=CGRect(x:UIScreen.main.bounds.width/2.1,y:UIScreen.main.bounds.height/1.3,width:200,height:200)
        }

    }





struct New_Previews: PreviewProvider {
    static var previews: some View {
        New()
    }
}

