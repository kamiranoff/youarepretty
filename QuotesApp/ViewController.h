//
//  ViewController.h
//  QuotesApp
//
//  Created by Kevin Amiranoff on 28/10/2017.
//  Copyright © 2017 Kevin Amiranoff. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *lblHomeTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblLanguage;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;

@property (nonatomic) NSArray *languagesData;
@property (nonatomic) NSDictionary *selectedLanguage;

- (IBAction)btnChangeLanguage:(id)sender;
- (IBAction)btnPlaySound:(id)sender;

- (NSDictionary *)getLanguage:(NSString *)languageCode;
- (void)changeYouArePrettyText:(NSString *)selectedLanguage;

@end

