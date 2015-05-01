//
//  ViewController.m
//  ScrabbleWordsReader
//
//  Created by Matt Glover on 28/09/2014.
//  Copyright (c) 2014 Duchy Software. All rights reserved.
//

#import "ViewController.h"
#import "ScrabbleWordsService.h"
#import "ScrabbleWord.h"

@interface ViewController () <UITextFieldDelegate, UITableViewDataSource>
@property (nonatomic, strong) ScrabbleWordsService *wordsService;
@property (nonatomic, strong) NSArray *validWords;
@property (weak, nonatomic) IBOutlet UITextField *lettersInputTextField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.wordsService = [[ScrabbleWordsService alloc] init];
    [self.lettersInputTextField becomeFirstResponder];
}

#pragma mark - TextField Delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if ([textField.text length] == 11) {
       self.validWords = [self.wordsService validWordsForLetters:[textField.text lowercaseString] orderedByMaxPoints:YES];
        [self.tableView reloadData];
        textField.text = nil;
        return NO;
    }
    
    return YES;
}

#pragma mark - UITableview Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.validWords count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DefaultCell" forIndexPath:indexPath];

    ScrabbleWord *word = self.validWords[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%d - %@", word.totalScore, word.word];
    
    return cell;
}

@end
