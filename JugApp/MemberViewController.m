//
//  MemberViewController.m
//  JugApp
//
//  Created by Christophe Hamerling on 25/07/11.
//  Copyright 2011 chamerling.org. All rights reserved.
//
// TODO : not used, should be removed...

#import "MemberViewController.h"
#import "Member.h"
#import "Utils.h"

#define kSectionInfos			0
#define kSectionBusiness		1
#define kSectionContact         2

#define kRowTagWeb				0
#define kRowTagEmail			1
#define kRowTagTWitter			2

#define kActionSheetOpenWebPage	1
#define kActionSheetSendEmail	2

@implementation MemberViewController
@synthesize member;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
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
    /*
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
                                     initWithTitle:@"Back"
                                     style:UIBarButtonItemStylePlain
                                     target:self
                                     action:@selector(back:)];
    self.navigationItem.leftBarButtonItem = backButton;
    [backButton release];
*/
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	NSInteger nbSections = 3;
	return nbSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // bio
    if (section == kSectionInfos) return 1;
    // email, twitter, web
    // TODO : adjust when some information is missing
    if (section == kSectionContact) return 3;
    // enterprise name + role in enterprise
    if (section == kSectionBusiness) return 2;
    return 0;
}

// create the header with name and the photo...
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    // not info section : NOP
	if (section != kSectionInfos) return nil;
    
	CGSize size = [member.name sizeWithFont:[UIFont boldSystemFontOfSize:17] constrainedToSize:CGSizeMake(280, 80) lineBreakMode:UILineBreakModeWordWrap];
	UIView *headerView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, size.height+40.0f)] autorelease];
    //	UILabel *nameLabel = [[[UILabel alloc] initWithFrame:CGRectMake(20, 20, 280, size.height+10)] autorelease];
	UILabel *nameLabel = [[[UILabel alloc] initWithFrame:CGRectMake(45, 20, 255, size.height+10)] autorelease];
	nameLabel.backgroundColor = [UIColor clearColor];
	nameLabel.text = member.name;
	nameLabel.font = [UIFont boldSystemFontOfSize:17];
	nameLabel.shadowColor = [UIColor whiteColor];
	nameLabel.shadowOffset = CGSizeMake(0, 1);
	nameLabel.numberOfLines = 3;
	[headerView addSubview:nameLabel];
	
	//UIImageView *imageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pin-down.png"]];
	UIImageView *imageView=[[[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 32,/* size.height+10*/32)] autorelease];
    
    // TODO : set avatar
    // get the gravatar for this user...
    UIImage *gravatar = [[Utils singleton] avatarWithEmail:member.email size:20.0f defaultImage:nil rating:nil error:nil];
    
	//imageView.image = [UIImage imageNamed:@"avatar.jpg"];
    imageView.image = gravatar;

	[headerView addSubview:imageView];
    
	return headerView;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	static NSString *DefaultCellIdentifier = @"DefaultCell";
	static NSString *ButtonCellIdentifier	= @"ButtonCell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DefaultCellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ButtonCellIdentifier] autorelease];
	}
	
    // fill the contact information
	if (indexPath.section == kSectionInfos) {
		cell.textLabel.text	= member.description;
		//cell.textLabel.textAlignment	= UITextAlignmentCenter;
		//UIImage *img2= [UIImage imageNamed:@"direction.png"];
		//cell.imageView.image = img2;
        
	} else if(indexPath.section == kSectionBusiness) {
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = member.company;
                break;
            case 1:
                cell.textLabel.text = member.role;
                break;
            default:
                break;
        }
            
    } else if (indexPath.section == kSectionContact) {
            switch (indexPath.row) {
                case kRowTagEmail:
                    cell.textLabel.text = NSLocalizedString(@"Email", @"");
                    cell.detailTextLabel.text = [member email];
                    //cell.detailTextLabel.numberOfLines = 3;
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

- (void)sendEmail {
	if (member.email == nil) return;
	NSURL *emailURL = [NSURL URLWithString:[NSString stringWithFormat:@"mailto:%@", member.email]];
	[[UIApplication sharedApplication] openURL:emailURL];
}

- (void) openWebPage {
    // TODO : create a web view for that...
    if (member.web == nil) return;
    NSURL *webURL = [NSURL URLWithString:member.web];
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
		default:
			break;
	}
}
@end
