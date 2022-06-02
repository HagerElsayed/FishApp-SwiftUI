//
//  ContentView.swift
//  FishDetails-SwiftUI
//
//  Created by Hager Elsayed on 25/05/2022.
//

import SwiftUI
import BottomSheet

struct FishDetails: View {
    let description = """
              Please add a right description here,
              Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no
              """
    @State var isPresent: Bool = false
    var body: some View {
        VStack {
            ArrowButton()
            ScrollView {
                VStack{
                    CircleWaveView(percent: Int(50.0))
                        .padding(30)
                        .onTapGesture {
                            isPresent.toggle()
                        }
                    
                    VStack(alignment: .leading, spacing: 20) {
                        HStack {
                            Text("Angle Fish")
                                .fontWeight(.bold)
                                .font(.title)
                                .foregroundColor(.fishAccentColor)
                            
                            Spacer()
                            Text("$30")
                                .fontWeight(.bold)
                                .font(.title)
                                .foregroundColor(.fishPrimaryColor)
                        }
                        
                        Text("Description")
                            .fontWeight(.regular)
                            .font(.title3)
                        
                        Text(description)
                            .fontWeight(.light)
                            .foregroundColor(.gray)
                            .padding(.bottom, 20)
                        
                        Button(action: {}) {
                            Text("Add to cart")
                                .foregroundColor(.white)
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .padding()
                                .background(Color.fishPrimaryColor)
                                .cornerRadius(20)
                        }
                        .padding([.leading, .trailing], 10)
                        
                        Spacer()
                    }
                    
                    .frame(width: UIScreen.main.bounds.width / 1.2)
                    .padding()
                    .overlay(
                    RoundedRectangle(cornerRadius: 24)
                        .stroke(Color.gray, lineWidth: 1)
                    )
                }
            }
        }
        .bottomSheet(isPresented: $isPresent, height: UIScreen.main.bounds.height - 80) {
            BottomView()
            
        }
    }
}

struct Wave: Shape {
    // we'll need to define [ offset and percent
    var offset: Angle
    var percent: Double
    
    var animatableData: Double {
        get {offset.degrees}
        set {offset = Angle(degrees: newValue)}
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let low = 0.02
        let high = 0.98
        
        let newPercent = low + (high - low) * percent
        let waveHeight = 0.015 * rect.height
        let yOffset = CGFloat(1 - newPercent) * (rect.height - 4 * waveHeight) + 2 * waveHeight
        let startAngle = offset
        let endAngle = offset + Angle(degrees: 360)
        
        path.move(to: CGPoint(x: 0, y: yOffset + waveHeight * CGFloat(sin(offset.radians))))
        
        for angle in stride(from: startAngle.degrees, through: endAngle.degrees, by: 5) {
            let x = CGFloat((angle - startAngle.degrees)/360) * rect.width
            path.addLine(to: CGPoint(x: x, y: yOffset + waveHeight * CGFloat(sin(Angle(degrees: angle).radians))))
        }
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        path.closeSubpath()
        return path
    }
}
struct CircleWaveView: View {
    let percent: Int
    @State private var waveOffset = Angle(degrees: 0)
    var body: some View {
        GeometryReader { geoReader in
            ZStack {
                Image("fish")
                
                Circle()
                    .stroke(Color.gray, lineWidth: 2)
                    .overlay(
                        Wave(offset: Angle(degrees: self.waveOffset.degrees), percent: Double(percent)/100)
                            .fill(Color.fishBlueColor)
                            .clipShape(Circle().scale(0.92))
                    )
                
            }
            
        }
        .aspectRatio(1, contentMode: .fit)
        .onAppear {
            withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: false)) {
                self.waveOffset = Angle(degrees: 360)
            }
        }
    }
}
struct ArrowButton: View {
    var body: some View {
        HStack {
            Button(action: {}) {
                Image(systemName: "arrow.backward.square.fill")
                    .font(.largeTitle)
                    .foregroundColor(Color.fishPrimaryColor)
                
            }
            
            Spacer()
        }
        .padding()
        .padding(.top, 30)
    }
}

struct FishDetails_Previews: PreviewProvider {
    static var previews: some View {
        FishDetails()
    }
}
