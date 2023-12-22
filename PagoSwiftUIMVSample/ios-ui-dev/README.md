# Pago UI - iOS SDK  ![apple](https://github.com/PagoApp/ios-ui-dev/assets/4348190/b17d95bc-3df7-487c-bbcd-a2b67378c2ad)


## 🌟 About the SDK
This is the Design Language System of Pago, it contains the common UI componenets and styleguides. 
This package is private, the ones that will integrate the SDK will have no access to any of its contents.

## ⚙️ Setup
The Pago RCA SDK supports iOS 13 and above and Xcode 13.3 and above.

The installation process is straighforward:

1. Using terminal git commands
position into the right location, where you would like to have the project
```
cd <parent_folder>
mkdir <Pago_SDK_folder>
cd <newly_created_folder>
 ```
2. clone the sources
Note: this step requires authentication in github, make sure you are logged in and the .netrc file is correctly set up. See more info here
```
git clone git@github.com:PagoApp/ios-integrator-dev.git
cd ios-integrator-dev
``` 
3. update all submodules and make sure they are on the correct commit branch
```
git submodule update --init --recursive
git submodule foreach -q --recursive 'branch="$(git config -f $toplevel/.gitmodules submodule.$name.branch)"; git switch $branch'
``` 

4. navigate through each repo (taking into cosideration their dependecy diagram) and make sure they are up to date and on the correct commit head (not detached)
Note: Execute the following steps for each of them, in this specific order: ios-core-dev, ios-network-dev, ios-ui-dev, ios-rca-dev
```
cd <folder_name>
git status
git pull
```

## 📚 Documentation
When working on the repo, make sure you read and update the required documentation as you progress:
- [General coding guidelines](https://app.gitbook.com/o/1VtGNAIrFNv1JDAuVcuI/s/RtWNtiixGRhvI36iaQda/general-guidelines/guidelines)
- [iOS architecture](https://pagojira.atlassian.net/wiki/spaces/PW/pages/2283929622/iOS+-+App+Architecture)
- [Internal SDK documentation](https://pago-integrations.gitbook.io/pago-sdk-internal-documentation/)
- [External SDK documentation](https://pago-integrations.gitbook.io/pago-docs/)
- [JSON doc](https://pagojira.atlassian.net/wiki/spaces/PW/pages/2449702944/V1+UI+config+documentation)

## 🚀 CI/CD
_Pending_

## 🐛 Testing
_Pending_

## 📝 Content
The sample app has the following components that you can view in multiple states:
1. Header image loaded from remote
2. Dark mode switch
3. PagoButton
4. PagoSelectorView
5. Styles
6. PagoEditText
7. PagoRadioGroup
8. PagoDetailView
9. PagoTextView
10. PagoAutoCompleteEditText
11. Intro Screen
12. RecyclerView sample
13. Checkboxes
14. Bottom Sheet - small size
15. Bottom Sheet - long size
16. Show loading button
17. Hide loading button

### (0) Main screen
| Main Screen (Day mode) | Main Screen (Night mode) | 
| ----------- | ----------- |
| <img src="https://user-images.githubusercontent.com/4348190/204849523-ca891b8b-929e-4b0d-9e16-220964a8a678.png" width="300"> | <img src="https://user-images.githubusercontent.com/4348190/204853302-0e5b1b33-76b6-4f12-90f4-c2a057d9790c.png" width="300"> |

### (3) Buttons

| Pago Button | Pago Button 2 | Pago Button 3 |
| ----------- | ----------- | ----------- |
| <img src="https://user-images.githubusercontent.com/4348190/204848103-0194aaf4-6563-4664-96a0-c62095e9642e.png" width="300"> | <img src="https://user-images.githubusercontent.com/4348190/204848164-9ebadbfa-42b5-4923-a867-48bbd96d0823.png" width="300"> | <img src="https://user-images.githubusercontent.com/4348190/204849148-27ccd02b-8c53-47a5-8c10-aed1537d6bab.png" width="300"> |

### (6) PagoEditText

| Edit Text |
| ----------- |
| <img src="https://user-images.githubusercontent.com/4348190/204850754-f634f84a-3422-4fe0-952b-22f852bcdea5.png" width="300"> |

### (9) PagoDetailView
| PagoDetailView |
| ----------- |
| <img src="https://user-images.githubusercontent.com/4348190/204851237-a0a6f8c2-fda1-4cd5-8e29-f8b2bceb0367.png" width="300"> |

### (13) PagoCheckbox
| Checkboxes |
| ----------- |
| <img src="https://user-images.githubusercontent.com/4348190/204851380-a336745c-5c55-464e-b240-b7542cc23ee1.png" width="300"> |

### (14) & (15) BottomSheet

| Small       | Long        | 
| ----------- | ----------- |
| <img src="https://user-images.githubusercontent.com/4348190/204851754-c0602a18-fa84-4cf2-9a02-dc89d599ed24.png" width="300"> | <img src="https://user-images.githubusercontent.com/4348190/204851761-c1e64c06-69c7-4cb3-a928-9478738c55de.png" width="300"> |

## 🌍 Localization
The UI sample has no localisation as the texts are added on the higher level modules (Bills, RCA, Pago etc)
