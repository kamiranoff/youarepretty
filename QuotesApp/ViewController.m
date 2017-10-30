//
//  ViewController.m
//  QuotesAppx
//
//  Created by Kevin Amiranoff on 28/10/2017.
//  Copyright © 2017 Kevin Amiranoff. All rights reserved.
//

#import "ViewController.h"
#import "JSONHelpers.h"

@interface ViewController ()

@property (strong, nonatomic) NSArray *languagesData;
@property (strong, nonatomic) NSDictionary *selectedLanguage;
@property (strong, nonatomic) AVSpeechSynthesizer *synthesizer;

@end

@implementation ViewController


- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  
  self.languagesData = [JSONHelpers JSONFromLanguagesFile];
//  self.languageNameList = [self getListOfLangueagesName];
  
  self.pickerView.delegate = self;
  self.pickerView.dataSource = self;

  self.synthesizer = [[AVSpeechSynthesizer alloc]init];

  
  NSString * selectedLanguageCode = [self.languagesData objectAtIndex:0][@"code"];
  self.selectedLanguage = [self getLanguage:selectedLanguageCode];
  
  [self changeYouArePrettyText:selectedLanguageCode];
  
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


- (void)changeYouArePrettyText:(NSString *)selectedLanguage {
  NSDictionary *language = [self getLanguage:selectedLanguage];
  NSArray *youArePrettyVariations = language[@"pretty"];
  NSArray *romanizationVariations = language[@"romanization"];
  NSString *youArePretty = @"We don't know yet...";
  NSString *romanization = nil;
 // BOOL isRightToLeft = language[@"rtl"];
  
  
  NSString *languageName = [NSString stringWithFormat:@"%@%@%@", @"(", language[@"name"], @")" ];

  if(youArePrettyVariations.count > 0) {
    youArePretty = youArePrettyVariations[0];
  }
  
  if(romanizationVariations.count > 0) {
    romanization = romanizationVariations[0];
    self.lblRomanization.text = romanization;
  }else {
    self.lblRomanization.text = nil;
  }
  
//  if(isRightToLeft) {
//     self.lblHomeTitle.textAlignment = NSTextAlignmentRight; // right to left
//  }else {
//    self.lblHomeTitle.textAlignment = NSTextAlignmentLeft; // Left to right
//  }

  [UIView transitionWithView:self.lblHomeTitle
                    duration:0.3f
                     options:UIViewAnimationOptionTransitionCrossDissolve
                  animations:^{

                    self.lblHomeTitle.text = youArePretty;

                  } completion:nil];
  
  
  self.lblLanguage.text = languageName;
}


-(NSDictionary *)getLanguage:(NSString *)languageCode {
  NSArray *languages = self.languagesData;
  NSUInteger objectIndex = [languages indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
    return (*stop = ([obj[@"code"] isEqualToString:languageCode]));
  }];

  return languages[objectIndex];
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
  return 1;// or the number of vertical "columns" the picker will show...
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
  if (self.languagesData!=nil) {
    return [self.languagesData count];//this will tell the picker how many rows it has - in this case, the size of your loaded array...
  }
  return 0;
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
  //you can also write code here to descide what data to return depending on the component ("column")
  if (self.languagesData!=nil) {
    
    NSDictionary * obj = [self.languagesData objectAtIndex:row];
    return obj[@"name"];//assuming the array contains strings..
  }
  return @"";//or nil, depending how protective you are
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
  NSDictionary *selectedLanguage = [self.languagesData objectAtIndex:[self.pickerView selectedRowInComponent:0]];
  [self setSelectedLanguage:selectedLanguage];
  [self changeYouArePrettyText:(NSString *)selectedLanguage[@"code"]];
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  UITouch *touch = [touches anyObject];
  
  if ([touch view] != self.pickerView)
    [self.pickerView endEditing:YES];
  self.pickerView.hidden = YES;
}

- (void)playSound:(NSString *)words languageCode:(NSString *)code {
  AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc]initWithString:words];
  AVSpeechSynthesisVoice *voice = [AVSpeechSynthesisVoice voiceWithLanguage:code];
  utterance.voice = voice;
  [self.synthesizer speakUtterance:utterance];
}

- (IBAction)btnChangeLanguage:(id)sender {
  self.pickerView.hidden = NO;
}

- (IBAction)btnPlaySound:(id)sender {
  
   NSDictionary * language = self.selectedLanguage;
  NSArray * youArePrettyArray = language[@"pretty"];
   NSString * languageCode = language[@"code"];
  NSString * youArePretty = nil;
  
  if(youArePrettyArray.count > 0) {
    youArePretty = language[@"pretty"][0];
  } else {
    return;
  }
  
  [self playSound:youArePretty languageCode:languageCode];
}


@end
