//
//  StatusProgressView.swift
//  SharedServices
//
//  Created by Nikita Skrypchenko on 05.12.2023.
//  Copyright © 2023 OporaOrg. All rights reserved.
//

import SwiftUI

public struct SmallStatusProgressView: View {
    let status: String
    let progress: Int

    public var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(status)
                    .foregroundColor(.green)
                    .font(.subheadline)
                
                Spacer()
                
                ProgressView(value: Double(progress), total: 100)
                    .accentColor(.green)
                    .frame(width: 100)
            }
        }
    }
}

public struct LargeStatusProgressView: View {
    let progress: CGFloat
    let maxValue: CGFloat

    private let height: CGFloat = 20

    init(progress: Int, maxValue: Int) {
        self.maxValue = CGFloat(maxValue)
        self.progress = CGFloat(progress) / self.maxValue
    }

    public var body: some View {
        GeometryReader { geometry in
            
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: geometry.size.width, height: height)
                    .opacity(0.3)
                    .foregroundColor(.green.opacity(0.4))
                Rectangle()
                    .frame(width: min(geometry.size.width * CGFloat(self.progress), geometry.size.width), height: height)
                    .foregroundColor(.green)
                    .animation(.linear, value: progress)
                
                Text("\(Int(progress * 100))/\(Int(maxValue))")
                    .foregroundColor(.black)
                    .font(.subheadline)
                    .bold()
                    .frame(width: geometry.size.width, height: height, alignment: .center)

            }
            .cornerRadius(height / 2)
            
            
        }
    }
}

struct LargeStatusProgressView_Preview: PreviewProvider {
    static var previews: some View {
        LargeStatusProgressView(progress: 40, maxValue: 100)
    }
    
}
