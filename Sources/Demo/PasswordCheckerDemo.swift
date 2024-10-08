//
//  PasswordCheckerDemo.swift
//  Adwaita
//
//  Created by lambdaclan on 13.06.24.
//
//  Adjusted by david-swift on 18.06.24.

// swiftlint:disable missing_docs no_magic_numbers

import Adwaita

enum PasswordChecker: String, CaseIterable, CustomStringConvertible, Identifiable {
    case length
    case upper
    case lower
    case special
    case numeric

    var id: String {
        self.rawValue
    }

    var label: String {
        switch self {
        case .length:
            return "Password Length"
        case .upper:
            return "Password Uppercase Characters"
        case .lower:
            return "Password Lowercase Characters"
        case .special:
            return "Password Special Characters"
        case .numeric:
            return "Password Numeric Characters"
        }
    }

    var description: String {
        switch self {
        case .length:
            return "Password needs to be greater than 8 characters long"
        case .upper:
            return "Password needs to contain at least one uppercase character"
        case .lower:
            return "Password needs to contain at least one lowercase character"
        case .special:
            return "Password needs to contain at least one special character `!&^%$#@()/`"
        case .numeric:
            return "Password needs to contain at least one numeric character"
        }
    }
}

struct PasswordCheckerDemo: View {

    var app: AdwaitaApp

    var view: Body {
        VStack {
            Button("View Demo") {
                app.showWindow("password-checker-demo")
            }
            .suggested()
            .pill()
            .frame(maxWidth: 100)
        }
    }

    struct WindowContent: View {

        @State private var password = ""
        @State private var copied: Signal = .init()

        var checkStatus: [String: Bool] {
            PasswordChecker.allCases.enumerated().reduce([String: Bool]()) { dict, checker in
                var dict = dict
                dict[checker.element.rawValue] = check(password: password, checker: checker.element).1
                return dict
            }
        }

        var view: Body {
            VStack {
                FormSection("") {
                    Form {
                        EntryRow("Password", text: $password)
                            .suffix {
                                Button(icon: .default(icon: .editCopy)) {
                                    AdwaitaApp.copy(password)
                                    copied.signal()
                                }
                                .flat()
                                .valign(.center)
                                .tooltip("Copy")
                                Button(icon: .default(icon: .editClear)) {
                                    password = ""
                                }
                                .flat()
                                .valign(.center)
                                .tooltip("Clear")
                            }
                    }
                }
                .padding()
                ForEach(PasswordChecker.allCases) { checker in
                    CheckerButton(
                        isValid: .constant(checkStatus[checker.rawValue] ?? false),
                        checkerName: checker.label,
                        checkerInfo: checker.description
                    )
                    .padding()
                }
            }
            .padding()
            .toast("Copied to clipboard", signal: copied)
            .frame(minWidth: 340, minHeight: 400)
            .topToolbar {
                HeaderBar.empty()
            }
        }

        private func check(password: String, checker: PasswordChecker) -> (String, Bool) {
            switch checker {
            case .length:
                return (PasswordChecker.length.rawValue, password.count > 8)
            case .upper:
                let result = password.range(of: ".*[A-Z]+.*", options: .regularExpression)
                return (PasswordChecker.upper.rawValue, result != nil ? true : false)
            case .lower:
                let result = password.range(of: ".*[a-z]+.*", options: .regularExpression)
                return (PasswordChecker.lower.rawValue, result != nil ? true : false)
            case .special:
                let result = password.range(of: ".*[!&^%$#@()/]+.*", options: .regularExpression)
                return (PasswordChecker.special.rawValue, result != nil ? true : false)
            case .numeric:
                let result = password.range(of: ".*[0-9]+.*", options: .regularExpression)
                return (PasswordChecker.numeric.rawValue, result != nil ? true : false)
            }
        }
    }

    private struct CheckerButton: View {

        @Binding var isValid: Bool
        @State var isInfoVisible = false

        var checkerName: String
        var checkerInfo: String

        var view: Body {
            if isValid {
                Button("") {
                    isInfoVisible = true
                }
                .child {
                    ButtonContent()
                        .iconName(Icon.DefaultIcon.emblemOk.string)
                        .label(checkerName)
                        .halign(.start)
                }
                .success()
                .alertDialog(
                    visible: $isInfoVisible,
                    heading: checkerName,
                    body: checkerInfo
                )
                .response("OK", role: .close) {}
            } else {
                Button("") {
                    isInfoVisible = true
                }
                .child {
                    ButtonContent()
                        .iconName(Icon.DefaultIcon.faceAngry.string)
                        .label(checkerName)
                        .halign(.start)
                }
                .destructive()
                .alertDialog(
                    visible: $isInfoVisible,
                    heading: checkerName,
                    body: checkerInfo
                )
                .response("OK", role: .close) {}
            }
        }
    }
}

// swiftlint:enable missing_docs no_magic_numbers
