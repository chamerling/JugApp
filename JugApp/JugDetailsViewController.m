//
//  JugDetailsViewController.m
//  JugApp
//
//  Created by Christophe Hamerling on 26/07/11.
//  Copyright 2011 chamerling.org. All rights reserved.
//
// First section : Short description row + more info row
// second section : Events row + News row
// third section : Members row + Speaker row

#import "JugDetailsViewController.h"
#import "MembersViewController.h"
#import "EventsViewController.h"
#import "NewsViewController.h"
#import "JSONLoader.h"
#import "WebViewController.h"

#define kSectionDescription		0
#define kSectionNews            1
#define kSectionPeople          2
#define kSectionContact         3
#define kSectionMore            4

#define kRowTagDescription      0

#define kRowTagMembers			0
#define kRowTagSpeakers			1

#define kRowTagEvents           1
#define kRowTagNews             0

#define kActionSheetOpenWebPage	1
#define kActionSheetSendEmail	2
#define kActionSheetShowTweets 3

// cells size
#define FONT_SIZE 14.0f
#define DESCRIPTION_FONT_SIZE 17.0f
// width for full screen, not for grouped cells... looks like it is around 300 pixels, fixed when needed directly in code...
#define CELL_CONTENT_WIDTH 320.0f
#define CELL_CONTENT_MARGIN 10.0f
#define DEFAULT_CELL_HEIGHT 44.0f

@implementation JugDetailsViewController
@synthesize jug;

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

# pragma mark - table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == kSectionDescription) {
        return 2;
    } else if (section == kSectionNews) {
        return 2;
    } else if (section == kSectionPeople) {
        return 2;
    } else if (section == kSectionContact) {
        return 3;
    } else if (section == kSectionMore) {
        return 1;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (indexPath.section == kSectionDescription && indexPath.row == kRowTagDescription) {
        CGFloat width = CELL_CONTENT_WIDTH;
        // dirty fix for grouped cells...
        if (tableView.style == UITableViewStyleGrouped) {
            width = CELL_CONTENT_WIDTH - 20;
        }
        
        NSString *text = jug.description;
        CGSize constraint = CGSizeMake(width - (CELL_CONTENT_MARGIN * 2), 20000.0f);
        CGSize size = [text sizeWithFont:[UIFont boldSystemFontOfSize:DESCRIPTION_FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
        // margin...
        CGFloat result = size.height + 20;
        return result;
    }
    return DEFAULT_CELL_HEIGHT;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *DefaultCellIdentifier = @"DefaultCell";
    static NSString *InfoIdentifier = @"CellInfo";
    static NSString *PeopleIdentifier = @"CellPeople";
    static NSString *NewsIdentifier = @"CellNews";
    static NSString *ContactIdentifier = @"CellContact";
    static NSString *MoreIdentifier = @"CellMore";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DefaultCellIdentifier];
    if (cell == nil) {
        if (indexPath.section == kSectionDescription) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:InfoIdentifier] autorelease];
        } else if (indexPath.section == kSectionNews) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NewsIdentifier] autorelease];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } else if (indexPath.section == kSectionPeople) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PeopleIdentifier] autorelease];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } else if (indexPath.section == kSectionContact) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:ContactIdentifier] autorelease];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } else if (indexPath.section == kSectionMore) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MoreIdentifier] autorelease];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    
    // fill the contact information
	if (indexPath.section == kSectionDescription) {
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text	= [jug description];
                cell.textLabel.numberOfLines = 0; // as many lines as needed...
                //cell.textLabel.font = [UIFont boldSystemFontOfSize:BIO_FONT_SIZE];
                cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
                // TODO one more line for description link
                break;
            case 1:
                cell.textLabel.text = NSLocalizedString(@"Details...", @"");
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                break;
            default:
                break;
        }
	} else if(indexPath.section == kSectionNews) {
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = NSLocalizedString(@"News", @"");
                break;
            case 1:
                cell.textLabel.text = NSLocalizedString(@"Events", @"");
                break;
            default:
                break;
        }
    } else if (indexPath.section == kSectionPeople) {
        switch (indexPath.row) {
            case kRowTagMembers:
                cell.textLabel.text = NSLocalizedString(@"Members", @"");
                break;
            case kRowTagSpeakers:
                cell.textLabel.text = NSLocalizedString(@"Speakers", @"");
            default:
                break;
        }
    } else if (indexPath.section == kSectionContact) {
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = NSLocalizedString(@"Email", @"");
                cell.detailTextLabel.text = jug.email;
                break;
            case 1:
                cell.textLabel.text = NSLocalizedString(@"Web", @"");
                cell.detailTextLabel.text = jug.website;
                break;
            case 2:
                cell.textLabel.text = NSLocalizedString(@"Twitter", @"");
                cell.detailTextLabel.text = jug.twitter;
                break;
            default:
                break;
        }
    } else if (indexPath.section == kSectionMore) {
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = NSLocalizedString(@"Locate on Map", @"");
                break;
            default:
                break;
        }
    }
	return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *result = nil;
    switch (section) {
        case kSectionNews:
            result = @"Activity";
            break;
        case kSectionPeople:
            result = @"People";
            break;
        case kSectionContact:
            result = @"Contact";
            break;
        case kSectionMore:
            result = @"More...";
            break;
        default:
            break;
    }
    return result;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
      
    /*
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UIActivityIndicatorView *activityView = 
    [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [activityView startAnimating];
    [cell setAccessoryView:activityView];
    [activityView stopAnimating];    
    [activityView release];
     */
        
    if (indexPath.section == kSectionPeople) {
        if (indexPath.row == kRowTagMembers) {
            MembersViewController *membersViewController = [[MembersViewController alloc] init];
            membersViewController.title = @"Members";
            
            // load the members, must be done in a separate thread and must change the cell accessor type to a spinner...
            JSONLoader *loader = [[JSONLoader alloc] init];
            NSString *membersURL = [NSString stringWithFormat:@"%@/members/all.json", jug.apiURL];
            NSMutableArray *members = [loader getMembersFromURL:membersURL];
            membersViewController.members = members;
            [loader release];
            [members release];
            
            [self.navigationController pushViewController:membersViewController animated:YES];
            [membersViewController release];

        } else if (indexPath.row == kRowTagSpeakers) {
            // TODO
            
        }
    } else if (indexPath.section == kSectionDescription) {
       // TODO
        
    } else if (indexPath.section == kSectionNews) {
        if (indexPath.row == kRowTagEvents) {
            EventsViewController *controller = [[EventsViewController alloc] init];
            controller.title = @"Events";
            
            // load the members, must be done in a separate thread and must change the cell accessor type to a spinner...
            JSONLoader *loader = [[JSONLoader alloc] init];
            NSString *url = [NSString stringWithFormat:@"%@/events/all.json", jug.apiURL];
            NSMutableArray *events = [loader getEventsFromURL:url];
            controller.events = events;
            [loader release];
            [events release];
            [self.navigationController pushViewController:controller animated:YES];
            [controller release];
            
        } else if (indexPath.row == kRowTagNews) {
            NewsViewController *controller = [[NewsViewController alloc] init];
            controller.title = @"News";
            JSONLoader *loader = [[JSONLoader alloc] init];
            NSString *url = [NSString stringWithFormat:@"%@/news/all.json", jug.apiURL];
            NSMutableArray *news = [loader getNewsFromURL:url];
            controller.news = news;
            [loader release];
            [news release];
                
            [self.navigationController pushViewController:controller animated:YES];
            [controller release];
            
        }
    } else if (indexPath.section == kSectionContact) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
            switch (indexPath.row) {
                case 0:
                    [self confirmEmail];
                    break;
                case 1:
                    [self confirmWebPage];
                    break;
                case 2:
                    [self showTweets];
                    break;
                default:
                    break;
            }
   }
}

#pragma mark - Actions

- (void)confirmEmail {
	if (jug.email == nil) return;
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
    if (jug.website == nil) return;
    WebViewController *controller = [[WebViewController alloc] init];
    controller.url = jug.website;
    controller.title = jug.website;
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
}

- (void)confirmWebPage {
	if (jug.website == nil) return;
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"Open JUG Web page?", @"")
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
	if (jug.email == nil) return;
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self;
    [picker setSubject:@"JUG Contact"];
    NSArray *emails = [[NSArray alloc] initWithObjects:jug.email, nil];
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
    if (jug.twitter == nil) return;
    NSString *twitter = [NSString stringWithFormat:@"http://m.twitter.com/%@", jug.twitter];
    // TODO : show tweets from twitter.com or load mobile webpage
    WebViewController *controller = [[WebViewController alloc] init];
    controller.url = twitter;
    controller.title = @"Tweets";
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];

    //NSURL *webURL = [NSURL URLWithString:twitter];
    //[[UIApplication sharedApplication] openURL:webURL];
}

- (void)showMap {
    
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


#pragma mark - Memory

- (void)dealloc {
    [jug release];
    [super dealloc];
}

@end
