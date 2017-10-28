//
//  ViewController.h
//  QuotesApp
//
//  Created by Kevin Amiranoff on 28/10/2017.
//  Copyright © 2017 Kevin Amiranoff. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *lblHomeTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblLanguage;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UIView *btnChangeLanguageContainer;

@property (nonatomic) NSDictionary *languagesData;
@property (nonatomic) NSArray *languageNameList;

- (IBAction)btnChangeLanguage:(id)sender;
- (IBAction)btnPickLanguage:(id)sender;

- (NSArray *)getListOfLangueagesName;

- (NSDictionary *)getLanguage:(NSString *)languageCode;
- (void)changeYouArePrettyText:(NSString *)selectedLanguage;

@end

