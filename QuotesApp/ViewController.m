//
//  ViewController.m
//  QuotesApp
//
//  Created by Kevin Amiranoff on 28/10/2017.
//  Copyright © 2017 Kevin Amiranoff. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  
  self.languagesData = [self JSONFromLanguagesFile];
  self.languageNameList = [self getListOfLangueagesName];
  
  self.pickerView.delegate = self;
  self.pickerView.dataSource = self;
  
  NSString * selectedLanguage = @"en";
  [self changeYouArePrettyText:selectedLanguage];
  
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


- (void)changeYouArePrettyText:(NSString *)selectedLanguage {
  NSDictionary *language = [self getLanguage:selectedLanguage];
  NSArray *youArePrettyVariations = language[@"pretty"];
  NSString *youArePretty = @"We don't know yet...";
  NSString *languageName = [NSString stringWithFormat:@"%@%@%@", @"(", language[@"name"], @")" ];
  
  if(youArePrettyVariations.count > 0) {
    youArePretty = language[@"pretty"][0];
  }
  
  [UIView transitionWithView:self.lblHomeTitle
                    duration:0.3f
                     options:UIViewAnimationOptionTransitionCrossDissolve
                  animations:^{
                    
                    self.lblHomeTitle.text = youArePretty;
                    
                  } completion:nil];
  
  self.lblLanguage.text = languageName;
}


-(NSDictionary *)getLanguage:(NSString *)languageCode {
  NSDictionary *dict = self.languagesData;
  return dict[languageCode];
}

- (NSDictionary *)JSONFromLanguagesFile
{
  NSString *path = [[NSBundle mainBundle] pathForResource:@"languages" ofType:@"json"];
  NSData *data = [NSData dataWithContentsOfFile:path];
  return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}

- (NSArray *) getListOfLangueagesName {
  
 NSMutableArray * listOfLanguagesName = [[NSMutableArray alloc] init];;
  NSDictionary *languageData = self.languagesData;
  for (NSString *language in languageData) {
    NSString * languageNameKey = [NSString stringWithFormat: @"%@.name", language];
    NSString * languageName = [languageData valueForKeyPath:languageNameKey];

    [listOfLanguagesName addObject:languageName];
  }
  
  NSArray * sortedArray = [listOfLanguagesName sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
  return sortedArray;
}

- (IBAction)btnChangeLanguage:(id)sender {
   self.pickerView.hidden = NO;
   self.btnChangeLanguageContainer.hidden = NO;
}

- (IBAction)btnPickLanguage:(id)sender {
  self.pickerView.hidden = YES;
  self.btnChangeLanguageContainer.hidden = YES;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
  return 1;// or the number of vertical "columns" the picker will show...
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
  if (self.languageNameList!=nil) {
    return [self.languageNameList count];//this will tell the picker how many rows it has - in this case, the size of your loaded array...
  }
  return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
  //you can also write code here to descide what data to return depending on the component ("column")
  if (self.languageNameList!=nil) {
    return [self.languageNameList objectAtIndex:row];//assuming the array contains strings..
  }
  return @"";//or nil, depending how protective you are
}

@end
