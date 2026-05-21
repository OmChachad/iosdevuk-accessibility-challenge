//
//  SocialLinksView.swift
//  IOSDevuk26
//

import SwiftUI

/// A horizontal row of tappable social/web links for a speaker.
struct SocialLinksView: View {
    let social: [SocialItem]
    let speakerName: String?

    var body: some View {
        HStack {
            ForEach(social, id: \.self) { item in
                if let url = URL(string: item.socialLink) {
                    Link(destination: url) {
                        Label(displayName(for: item.socialType), systemImage: iconName(for: item.socialType))
                            .font(.subheadline)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 4)
                    }
                    .contentShape(.rect)
                    .accessibilityLabel(accessibilityLabel(for: item))
                    .accessibilityHint("Opens in your browser")
                }
            }
        }
        .accessibilityElement(children: .contain)
    }

    private func iconName(for type: String) -> String {
        switch type.lowercased() {
        case "twitter", "x": return "at"
        case "mastodon": return "at.badge.plus"
        case "github": return "chevron.left.forwardslash.chevron.right"
        case "linkedin": return "person.crop.square"
        case "website", "web", "blog": return "globe"
        default: return "link"
        }
    }

    private func displayName(for type: String) -> String {
        switch type.lowercased() {
        case "x":
            return "X"
        case "web":
            return "Website"
        default:
            return type.capitalized
        }
    }

    private func accessibilityLabel(for item: SocialItem) -> String {
        let destination = displayName(for: item.socialType)
        if let speakerName {
            return "\(speakerName)'s \(destination)"
        }
        return destination
    }
}
