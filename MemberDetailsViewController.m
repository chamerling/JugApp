//
//  MemberDetailsViewController.m
//  JugApp
//
//  Created by Christophe Hamerling on 29/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MemberDetailsViewController.h"
#import "Member.h"
// for email...
#import <MessageUI/MessageUI.h>
#import "Utils.h"

#define kSectionInfos			0
#define kSectionBusiness		1
#define kSectionContact         2

#define kRowTagWeb				0
#define kRowTagEmail			1
#define kRowTagTWitter			2

#define kActionSheetOpenWebPage	1
#define kActionSheetSendEmail	2
#define kActionSheetShowTweets  3

// cells size
#define FONT_SIZE 14.0f
#define BIO_FONT_SIZE 17.0f
// width for full screen, not for grouped cells... looks like it is around 300 pixels, fixed when needed directly in code...
#define CELL_CONTENT_WIDTH 320.0f
#define CELL_CONTENT_MARGIN 10.0f
#define DEFAULT_CELL_HEIGHT 44.0f

@implementation MemberDetailsViewController

@synthesize member;

- (id)initWithStyle:(UITableViewStyle)style
{
    // TODO : check if it is the right way...
    //self = [super initWithStyle:style];

    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == kSectionInfos) {
	return [member.name sizeWithFont:[UIFont boldSystemFontOfSize:17] constrainedToSize:CGSizeMake(280, 80) lineBreakMode:UILineBreakModeWordWrap].height+40.0f;
    } else {
        return +20.0f;
    }
}

// change the cell size for the bio in order to diaply all the text...
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (indexPath.section == kSectionInfos) {
        CGFloat width = CELL_CONTENT_WIDTH;
        // dirty fix for grouped cells...
        if (tableView.style == UITableViewStyleGrouped) {
            width = CELL_CONTENT_WIDTH - 20;
        }
        
        NSString *text = member.bio;
        CGSize constraint = CGSizeMake(width - (CELL_CONTENT_MARGIN * 2), 20000.0f);
        CGSize size = [text sizeWithFont:[UIFont boldSystemFontOfSize:BIO_FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
        // margin...
        CGFloat result = size.height + 20;
        return result;
    }
    return DEFAULT_CELL_HEIGHT;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // bio
    if (section == kSectionInfos) {
        if (YES) {
            // test the length
            return 1;
        } else {
            // return 2 rows in the section if the bio is too long...
            return 2;
        }
    }
    // email, twitter, web
    // TODO : adjust when some information is missing
    if (section == kSectionContact) return 3;
    // enterprise name + role in enterprise
    if (section == kSectionBusiness) return 2;
    
    // should not happen...
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *DefaultCellIdentifier = @"DefaultCell";
    static NSString *InfoIdentifier = @"CellInfo";
    static NSString *BusinessIdentifier = @"CellBusiness";
    static NSString *COntactIdentifier = @"CellContact";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DefaultCellIdentifier];
    if (cell == nil) {
        if (indexPath.section == kSectionContact) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:COntactIdentifier] autorelease];
        } else if (indexPath.section == kSectionBusiness) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:BusinessIdentifier] autorelease];
        } else if (indexPath.section == kSectionInfos) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:InfoIdentifier] autorelease];
        }
    }
    
    // fill the contact information
	if (indexPath.section == kSectionInfos) {
		cell.textLabel.text	= [member bio];
        cell.textLabel.numberOfLines = 0; // as many lines as needed...
        cell.textLabel.font = [UIFont boldSystemFontOfSize:BIO_FONT_SIZE];
        cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
	} else if(indexPath.section == kSectionBusiness) {
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = NSLocalizedString(@"Company", @"");
                cell.detailTextLabel.text = [member company];
                break;
            case 1:
                cell.textLabel.text = NSLocalizedString(@"Role", @"");
                cell.detailTextLabel.text = [member role];
                break;
            default:
                break;
        }
    } else if (indexPath.section == kSectionContact) {
        switch (indexPath.row) {
            case kRowTagEmail:
                cell.textLabel.text = NSLocalizedString(@"Email", @"");
                cell.detailTextLabel.text = [member email];
                break;
            case kRowTagWeb:
                cell.textLabel.text = NSLocalizedString(@"Web", @"");
                cell.detailTextLabel.text = member.web;
                break;
            case kRowTagTWitter:
                cell.textLabel.text = NSLocalizedString(@"Twitter", @"");
                cell.detailTextLabel.text = member.twitter;
                break;
            default:
                break;
        }
    }
	return cell;
}

// create the header with name and the photo...
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    // not info section : NOP
	if (section != kSectionInfos) return nil;
    
    // section info...
	CGSize size = [member.name sizeWithFont:[UIFont boldSystemFontOfSize:17] constrainedToSize:CGSizeMake(280, 80) lineBreakMode:UILineBreakModeWordWrap];
	UIView *headerView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, size.height+40.0f)] autorelease];
    //	UILabel *nameLabel = [[[UILabel alloc] initWithFrame:CGRectMake(20, 20, 280, size.height+10)] autorelease];
	UILabel *nameLabel = [[[UILabel alloc] initWithFrame:CGRectMake(60, 20, 255, size.height+10)] autorelease];
	nameLabel.backgroundColor = [UIColor clearColor];
	nameLabel.text = member.name;
	nameLabel.font = [UIFont boldSystemFontOfSize:17];
	nameLabel.shadowColor = [UIColor whiteColor];
	nameLabel.shadowOffset = CGSizeMake(0, 1);
	nameLabel.numberOfLines = 0;
	[headerView addSubview:nameLabel];
    UIImageView *imageView=[[[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 32,/* size.height+10*/32)] autorelease];
    // TODO : set avatar
    UIImage *gravatar = [[Utils singleton] avatarWithEmail:member.email size:32.0f defaultImage:nil rating:nil error:nil];

	//imageView.image = [UIImage imageNamed:@"avatar.jpg"];
    imageView.image = gravatar;

	[headerView addSubview:imageView];
    
	return headerView;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *result = nil;
    switch (section) {
        case kSectionBusiness:
            result = @"Job info";
            break;
        case kSectionContact:
            result = @"Contact";
            break;
        case kSectionInfos:
            result = @"Information";
            break;
        default:
            break;
    }
    return result;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == kSectionContact) {
        switch (indexPath.row) {
			case kRowTagWeb:
				[self confirmWebPage];
				break;
			case kRowTagTWitter:
				[self showTweets];
				break;
			case kRowTagEmail:
				[self confirmEmail];
				break;
			default:
				break;
		}
    }
}

#pragma mark - Actions

- (void)confirmEmail {
	if (member.email == nil) return;
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"Send an email?", @"")
                                                             delegate:self 
                                                    cancelButtonTitle:NSLocalizedString(@"No", @"") 
                                               destructiveButtonTitle:nil 
                                                    otherButtonTitles:NSLocalizedString(@"Yes", @""), nil];
	actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
	actionSheet.tag = kActionSheetSendEmail;
	[actionSheet showInView:self.view];
	[actionSheet release];
}

- (void) openWebPage {
    // TODO : create a web view for that...
    if (member.web == nil) return;
    NSURL *webURL = [NSURL URLWithString:member.web];
    [[UIApplication sharedApplication] openURL:webURL];
}

- (void)confirmWebPage {
	if (member.web == nil) return;
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"Open Web page?", @"")
                                                             delegate:self 
                                                    cancelButtonTitle:NSLocalizedString(@"No", @"") 
                                               destructiveButtonTitle:nil 
                                                    otherButtonTitles:NSLocalizedString(@"Yes", @""), nil];
	actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
	actionSheet.tag = kActionSheetOpenWebPage;
	[actionSheet showInView:self.view];
	[actionSheet release];
}

- (void)sendEmail {
	if (member.email == nil) return;
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self;
    [picker setSubject:@"JUG Contact"];
    NSArray *emails = [[NSArray alloc] initWithObjects:member.email, nil];
    [picker setToRecipients:emails];
    [self presentModalViewController:picker animated:YES];
    [picker release];
    [emails release];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller  
          didFinishWithResult:(MFMailComposeResult)result 
                        error:(NSError*)error;
{
    if (result == MFMailComposeResultSent) {
        NSLog(@"It's away!");
    }
    [self dismissModalViewControllerAnimated:YES];
}

- (void) showTweets {
    if (member.twitter == nil) return;
    NSString *twitter = [NSString stringWithFormat:@"http://twitter.com/%@", member.twitter];
    NSURL *webURL = [NSURL URLWithString:twitter];
    [[UIApplication sharedApplication] openURL:webURL];
}

#pragma mark Action Sheet

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	switch (actionSheet.tag) {
		case kActionSheetOpenWebPage:
			if (buttonIndex == 0) {
				[self openWebPage];
			}
			break;
		case kActionSheetSendEmail:
			if (buttonIndex == 0) {
				[self sendEmail];
			}
			break;
		case kActionSheetShowTweets:
			if (buttonIndex == 0) {
				[self showTweets];
			}
			break;		
        default:
			break;
	}
}

@end
