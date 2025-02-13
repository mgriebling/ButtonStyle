//
//  CapsuleButtonStyle.swift
//  ButtonStyle
//
//  Created by Will Ellis on 2/16/23.
//

import SwiftUI

// Creating a customizable ButtonStyle to apply to a Button
// Pros:
//   ✅ Supports multiple color schemes
//   ✅ Encapsulated, reusable, and DRY styling
//   ✅ Access to button states
//   ✅ Styling and content are decoupled
//   ✅ Can use existing button initializers
//
// Cons:
//   ❌ So customizable 😵‍💫
struct RectButtonStyle: ButtonStyle {

    struct ColorScheme {
        let foregroundColor: Color
        let backgroundColor: Color
        let outlineColor: Color?
    }

    let enabledColorScheme: ColorScheme
    let pressedColorScheme: ColorScheme
    let hoveredColorScheme: ColorScheme
    let disabledColorScheme: ColorScheme

    func makeBody(configuration: Configuration) -> some View {
        StyleBody(
            configuration: configuration,
            enabledColorScheme: enabledColorScheme,
            pressedColorScheme: pressedColorScheme,
            hoveredColorScheme: hoveredColorScheme,
            disabledColorScheme: disabledColorScheme
        )
    }

    private struct StyleBody: View {

        let configuration: Configuration
        let enabledColorScheme: ColorScheme
        let pressedColorScheme: ColorScheme
        let hoveredColorScheme: ColorScheme
        let disabledColorScheme: ColorScheme

        private var isPressed: Bool {
            configuration.isPressed
        }

        @Environment(\.isEnabled)
        private var isEnabled

        @State
        private var isHovered: Bool = false

        private let shape = RoundedRectangle(cornerRadius: 0)

        private var colorScheme: ColorScheme {
            if !isEnabled {
                return disabledColorScheme
            } else if isPressed {
                return pressedColorScheme
            } else if isHovered {
                return hoveredColorScheme
            } else {
                return enabledColorScheme
            }
        }

        var body: some View {
            configuration.label
                .padding(.vertical, 12)
                .padding(.horizontal, 24)
                .foregroundColor(colorScheme.foregroundColor)
                .background(shape.fill(colorScheme.backgroundColor))
                .overlay(
                    shape.strokeBorder(colorScheme.outlineColor ?? .clear)
                )
                .onHover { isHovered in
                    self.isHovered = isHovered
                }
        }
    }
}

extension ButtonStyle where Self == RectButtonStyle {
    static var primary: Self {
        RectButtonStyle(
            enabledColorScheme: .init(
                foregroundColor: .primaryEnabledForeground,
                backgroundColor: .primaryEnabledBackground,
                outlineColor: .primaryEnabledOutline
            ),
            pressedColorScheme: .init(
                foregroundColor: .primaryPressedForeground,
                backgroundColor: .primaryPressedBackground,
                outlineColor: .primaryPressedOutline
            ),
            hoveredColorScheme: .init(
                foregroundColor: .primaryHoveredForeground,
                backgroundColor: .primaryHoveredBackground,
                outlineColor: .primaryHoveredOutline
            ),
            disabledColorScheme: .init(
                foregroundColor: .primaryDisabledForeground,
                backgroundColor: .primaryDisabledBackground,
                outlineColor: nil
            )
        )
    }

    static var secondary: Self {
        RectButtonStyle(
            enabledColorScheme: .init(
                foregroundColor: .secondaryEnabledForeground,
                backgroundColor: .secondaryEnabledBackground,
                outlineColor: .secondaryEnabledOutline
            ),
            pressedColorScheme: .init(
                foregroundColor: .secondaryPressedForeground,
                backgroundColor: .secondaryPressedBackground,
                outlineColor: .secondaryPressedOutline
            ),
            hoveredColorScheme: .init(
                foregroundColor: .secondaryHoveredForeground,
                backgroundColor: .secondaryHoveredBackground,
                outlineColor: .secondaryHoveredOutline
            ),
            disabledColorScheme: .init(
                foregroundColor: .secondaryDisabledForeground,
                backgroundColor: .secondaryDisabledBackground,
                outlineColor: nil
            )
        )
    }

    // NOTE: We could have built this into the "primary" style using
    //   the `role` attribute of `ButtonStyle.Configuration`
    static var destructive: Self {
        RectButtonStyle(
            enabledColorScheme: .init(
                foregroundColor: .destructiveEnabledForeground,
                backgroundColor: .destructiveEnabledBackground,
                outlineColor: .destructiveEnabledOutline
            ),
            pressedColorScheme: .init(
                foregroundColor: .destructivePressedForeground,
                backgroundColor: .destructivePressedBackground,
                outlineColor: .destructivePressedOutline
            ),
            hoveredColorScheme: .init(
                foregroundColor: .destructiveHoveredForeground,
                backgroundColor: .destructiveHoveredBackground,
                outlineColor: .destructiveHoveredOutline
            ),
            disabledColorScheme: .init(
                foregroundColor: .destructiveDisabledForeground,
                backgroundColor: .destructiveDisabledBackground,
                outlineColor: nil
            )
        )
    }
}



struct RectButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            VStack {
                Button("Primary") {}
                    .buttonStyle(.primary)

                Button("Secondary") {}
                    .buttonStyle(.secondary)

                Button("Disabled") {}
                    .disabled(true)

                Button {} label: {
                    HStack(spacing: 12) {
                        Image(systemName: "lightbulb")
                        Text("Custom Content")
                        Image(systemName: "arrow.forward")
                    }
                }

                Button("Destructive") {}
                    .buttonStyle(.destructive)
            }
            .buttonStyle(.secondary)
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.darkGray))
        //.background(Color(uiColor: .systemGray2))
    }
}
