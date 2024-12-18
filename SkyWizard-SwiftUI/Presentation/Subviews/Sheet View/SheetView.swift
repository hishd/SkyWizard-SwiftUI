//
//  SheetView.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 03/11/2024.
//

import SwiftUI

struct SheetView<Content: View>: View {
    
    var fill: Color = .white
    var shadowRadius: CGFloat = 10
    var opacity: Double = 0.1
    var cornerRadius: CGFloat = 30
    var isHandleVisible: Bool = false
    var isBackgroundVisible: Bool = true
    
    @State private var offset: CGFloat = 0
    @State private var lastOffset: CGFloat = 0
    @GestureState private var gestureOffset: CGFloat = 0
    @Binding var isPresented: Bool
    var content:  () -> Content
    
    var body: some View {
        GeometryReader { proxy in
            let height = proxy.frame(in: .global).height
            let initialOffset: CGFloat = height - 300
            let maximumGestureOffset: CGFloat = (height/5) + 100
            let maximumExpandedOffset: CGFloat = -(height / 4)
            let expansionTriggerOffset: CGFloat = 100
            
            ZStack {
                if isBackgroundVisible {
                    Rectangle()
                        .foregroundStyle(fill.opacity(opacity))
                        .background(.ultraThinMaterial)
                        .shadow(radius: shadowRadius)
                        .clipShape(CustomCorner(corners: [.topLeft, .topRight], radius: cornerRadius))
                }
                
                VStack {
                    if isBackgroundVisible && isHandleVisible {
                        Capsule()
                            .fill(.black)
                            .frame(width: 68, height: 4, alignment: .center)
                            .padding(.top, 10)
                    }
                    
                    content()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            }
            .frame(height: (height/2) + 220)
            .offset(y: initialOffset)
            .offset(y: offset)
            .gesture(DragGesture().updating($gestureOffset) { value, out, _ in
                out = value.translation.height
                if -value.translation.height < maximumGestureOffset && -offset < maximumGestureOffset {
                    onChange()
                }
            }
                .onEnded({ value in
                    withAnimation {
                        if -offset > expansionTriggerOffset {
                            isPresented = true
                            offset = maximumExpandedOffset
                        } else {
                            offset = 0
                        }
                        
                        lastOffset = offset
                    }
                })
            )
            .onChange(of: isPresented) { value in
                withAnimation {
                    offset = value ? maximumExpandedOffset : 0
                }
            }
        }
        .ignoresSafeArea(.all, edges: .bottom)
    }
    
    func onChange() {
        DispatchQueue.main.async {
            self.offset = gestureOffset + lastOffset
        }
    }
}

private struct CustomCorner: Shape {
    var corners: UIRectCorner
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return .init(path.cgPath)
    }
}

#if DEBUG
#Preview {
    StatePreviewWrapper(value: true) { $value in
        ZStack {
            GeometryReader { proxy in
                let frame = proxy.frame(in: .global)
                
                Image(.mountain)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: frame.width, height: frame.height)
            }
            .ignoresSafeArea()
            SheetView(isPresented: $value) {
                Text("Hello, Content!")
            }
        }
        .onTapGesture {
            value = false
        }
    }
}
#endif
